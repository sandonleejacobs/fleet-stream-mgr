import asyncio
import random
import pandas as pd
import streamlit as st
from st_aggrid import AgGrid, GridOptionsBuilder
from st_aggrid.shared import GridUpdateMode
from pandas import DataFrame

from api.auth import AuthEndpoint
from api.statements import StatementsEndpoint
from lib.config import Config
from lib.flink import Changelog

async def query(conf, sql, continuous_query):
    auth = AuthEndpoint(conf)
    statements = StatementsEndpoint(auth, conf)

    stmt = await statements.create(sql)
    print(f'running statement {sql}')
    ready = await statements.wait_for_status(stmt, 'running', 'completed')
    print(f'ready = {ready}')
    schema = ready['status']['result_schema']
    name = ready['name']
    # this is an async generator, not a blocking function
    results = statements.results(name, continuous_query)
    return results, schema


async def populate_fleet_table(widget, continuous_query):
    conf = Config('./config.yml')
    print(conf)

    sql = """select vehicle_id, driver_name, license_plate from fleet_mgmt_description;"""
    results, schema = await query(conf, sql, continuous_query)
    print(f'results = {results}')
    changelog = Changelog(schema, results)
    await changelog.consume(1)
    table = changelog.collapse()
    while True:
        new_data = await changelog.consume(1)
        table.update(new_data)
        # wait until we get the update-after to render, otherwise graphs
        # and tables content "jump" around.
        if new_data[0][0] != "-U":
            df = DataFrame(table, None, table.columns)
            df.sort_values(by=df.columns[0], inplace=True)
            widget.dataframe(df, hide_index=True,
                             column_config={"vehicle_id": "vehicle_id", "driver_name": "driver_name", "license_plate": "license_plate"})
        await asyncio.sleep(0.01)


async def main():
    st.set_page_config(
        layout="wide", page_icon="🖱️", page_title="App"
    )
    st.title("🖱️ App")
    st.write(
        """Is this thing on?"""
    )

    col1, col2 = st.columns(2)

    with col1:
        st.header("Fleet")

        fleet_table = st.table()
        await asyncio.gather(
            populate_fleet_table(fleet_table, continuous_query=True)
        )


# if __name__ == "__main__":
asyncio.run(main())
