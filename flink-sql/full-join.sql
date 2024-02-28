--full join locations and sensors.
--should show us the location and time at which a temp reading occurred
select loc.vehicle_id as vehicleId, loc.location as location, loc.ts as locTime, sens.engine_temperature as engineTemp, sens.average_rpm as rpms,
    COALESCE(loc.window_start, sens.window_start) as window_start,
    COALESCE(loc.window_end, sens.window_end) as window_end
from (
    SELECT * from TABLE(TUMBLE(TABLE fleet_mgmt_location, descriptor($rowtime), INTERVAL '2' MINUTES))
) loc
full join (
    SELECT * from TABLE(TUMBLE(TABLE fleet_mgmt_sensors, descriptor($rowtime), INTERVAL '2' MINUTES))
) sens
on loc.vehicle_id = sens.vehicle_id and loc.window_start = sens.window_start and loc.window_end = sens.window_end;


select des.vehicle_id, des.driver_name, des.license_plate, loc.location, loc.ts,
    COALESCE(des.window_start, loc.window_start) as window_start,
    COALESCE(des.window_end, loc.window_end) as window_end
from (
    SELECT * from TABLE(TUMBLE(TABLE fleet_mgmt_description, descriptor($rowtime), INTERVAL '10' MINUTES))
) des
left join (
    SELECT * from TABLE(TUMBLE(TABLE na_fleet_mgmt_location, descriptor($rowtime), INTERVAL '2' MINUTES))
) loc
on des.vehicle_id = loc.vehicle_id and des.window_start = loc.window_start and des.window_end = loc.window_end;

