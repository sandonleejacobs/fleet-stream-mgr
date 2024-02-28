-- semi join
select * from (
    SELECT * from TABLE(TUMBLE(TABLE fleet_mgmt_location, descriptor($rowtime), INTERVAL '2' MINUTES))
) loc where loc.vehicle_id in (
    SELECT vehicle_id FROM (
        SELECT * from TABLE(TUMBLE(TABLE fleet_mgmt_sensors, descriptor($rowtime), INTERVAL '2' MINUTES))
    ) sens where loc.window_start = sens.window_start and loc.window_end = sens.window_end
);


create table na_fleet_mgmt_locations (
    vehicle_id INT NOT NULL,
    location ROW<`latitude` DOUBLE NOT NULL, `longitude` DOUBLE NOT NULL> NOT NULL,
    ts TIMESTAMP(3) NOT NULL,
    PRIMARY KEY (vehicle_id, ts) NOT ENFORCED
) with ('kafka.partitions' = '3', 'value.format' = 'avro-registry', 'key.format' = 'avro-registry');


-- useful date math, since this datagen data is OLD
-- also updates to the lat/long to put this in the continental US.
insert into na_fleet_mgmt_locations select
    vehicle_id,
    TIMESTAMPADD(MONTH, 20, ts) as ts,
    ((location.latitude + 35.0),(location.longitude - 81.0)) as location
from fleet_mgmt_location;


select d.vehicle_id, d.driver_name, d.license_plate, l.ts, l.location from na_fleet_mgmt_locations l, fleet_mgmt_description d
 where d.vehicle_id = l.vehicle_id and l.ts between TO_TIMESTAMP('2021-01-01 00:00:00') and TO_TIMESTAMP('2024-02-23 16:00:00');


