DROP TABLE dw_level.fct_orders_mm;
CREATE TABLE dw_level.fct_orders_mm
(
    client_surr_id      NUMBER(22)
        CONSTRAINT pk_client_id
            REFERENCES st_layer.t_st_clients,
    driver_surr_id      NUMBER(22)
        CONSTRAINT pk_driver_id
            REFERENCES st_layer.t_st_drivers,
    trip_id             NUMBER(22)
        CONSTRAINT trip_id
            REFERENCES st_layer.t_st_trips,
    avg_revenue         NUMBER(22),
    avg_trip_duration   NUMBER(22)    
);

select * from dw_level.fct_orders_mm;

INSERT INTO dw_level.fct_orders_mm (client_surr_id, driver_surr_id, trip_id, avg_revenue, avg_trip_duration)
SELECT 
       trips.trip_client_id
      ,trips.trip_driver_id
      ,trips.trip_id
      ,avg(trips.trip_cost)
      ,avg(trips.trip_duration)
FROM st_layer.t_st_trips trips
    LEFT JOIN st_layer.t_st_clients  c
        ON (c.client_id = trips.trip_client_id)
    LEFT JOIN st_layer.t_st_drivers  d
        ON (d.driver_id = trips.trip_driver_id) 
group by trips.trip_client_id, trips.trip_driver_id, trips.trip_id;