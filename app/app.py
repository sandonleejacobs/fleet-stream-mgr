import asyncio
import random
import pandas as pd
import streamlit as st
from st_aggrid import AgGrid, GridOptionsBuilder
from st_aggrid.shared import GridUpdateMode
from pandas import DataFrame

async def main():
    st.set_page_config(
        layout="wide", page_icon="🖱️", page_title="App"
    )
    st.title("🖱️ App")
    st.write(
        """Is this thing on?"""
    )


# if __name__ == "__main__":
asyncio.run(main())
