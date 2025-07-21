/* In case studies 1 and 2, we used relational database schemas to store the data that will be used by machine learning models.
For case study 1, we modeled the entities: machine_failures, machines, and failure_types, whose SQL schema is presented below: */

/* Main Table: machine_failures */

CREATE TABLE machine_failures (
    record_id INT PRIMARY KEY,
    machine_id INT NOT NULL,
    type_of_failure INT NOT NULL,
    timestamp BIGINT NOT NULL,
    time_repair FLOAT NOT NULL,
    cost FLOAT NOT NULL,
    criticality FLOAT NOT NULL,
    humidity INT NOT NULL,
    temperature INT NOT NULL,
    label INT NOT NULL,
    FOREIGN KEY (machine_id) REFERENCES machines(machine_id),
    FOREIGN KEY (type_of_failure) REFERENCES failure_types(type_id)
);

/* Support Tables: Machines: */

CREATE TABLE machines (
    machine_id INT PRIMARY KEY,
    machine_name VARCHAR(100),
    installation_date DATE,
    last_maintenance_date DATE,
    operational_status VARCHAR(50),
    department VARCHAR(50)
);

/* Support Table: Failure Types: */

CREATE TABLE failure_types (
    type_id INT PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL,
    severity_level VARCHAR(50),
    common_causes TEXT,
    recommended_actions TEXT
);

/* For case study 2, we modeled the entities: machine_condition, machines, and failure_alerts, whose SQL schema is presented below: */

/* Main Table: machine_condition */

CREATE TABLE machine_condition (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    sensor_1 DECIMAL(10, 4) NOT NULL,  -- Sensor S1 reading
    sensor_2 DECIMAL(10, 4) NOT NULL,  -- Sensor S2 reading
    sensor_3 DECIMAL(10, 4) NOT NULL,  -- Sensor S3 reading
    sensor_4 DECIMAL(10, 4) NOT NULL,  -- Sensor S4 reading
    sensor_5 DECIMAL(10, 4) NOT NULL,  -- Sensor S5 reading
    sensor_6 DECIMAL(10, 4) NOT NULL,  -- Sensor S6 reading
    sensor_7 DECIMAL(10, 4) NOT NULL,  -- Sensor S7 reading
    failure_condition DECIMAL(10, 4) NOT NULL,  -- Decimal value of the failure condition
    label TINYINT NOT NULL,  -- 0 (no failure) or 1 (failure)
    machine_id INT,  -- relationship with the machines table
    FOREIGN KEY (machine_id) REFERENCES machines(machine_id)
);

/* Support Table: machines */

CREATE TABLE machines (
    machine_id INT PRIMARY KEY AUTO_INCREMENT,
    machine_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    manufacturer VARCHAR(100),
    installation_date DATE,
    last_maintenance_date DATE
);

/* Alerts Table: failure_alerts (Records alerts when a failure is detected, i.e., label = 1) */

CREATE TABLE failure_alerts (
    alert_id INT PRIMARY KEY AUTO_INCREMENT,
    record_id INT NOT NULL,
    alert_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    severity ENUM('low', 'medium', 'high') DEFAULT 'medium',
    resolved BOOLEAN DEFAULT FALSE,
    notes TEXT,
    FOREIGN KEY (record_id) REFERENCES machine_condition(record_id)
);