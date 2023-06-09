\c postgres
DROP DATABASE IF EXISTS airbnb; -- drop the airbnb database if it exists
CREATE DATABASE airbnb; -- create the airbnb database


\c airbnb
DROP DATABASE IF EXISTS postgres; -- drop the postgres database if it exists


-- @block create location table
DROP TABLE IF EXISTS locations;
CREATE TABLE IF NOT EXISTS locations (
    id SERIAL PRIMARY KEY
    ,neighborhood VARCHAR -- note neighbourhood in csv
    ,latitude NUMERIC(6,4)
    ,longitude NUMERIC(6,4)
    ,neighborhood_overview TEXT   
);


-- @block create host table
DROP TABLE IF EXISTS hosts;
CREATE TABLE IF NOT EXISTS hosts (
    id SERIAL PRIMARY KEY
    ,host_id INT
    ,url VARCHAR
    ,name VARCHAR
    ,since DATE
    ,location VARCHAR
    ,about TEXT
    ,response_rate INT CHECK (response_rate <= 100)
    ,acceptance_rate INT CHECK (acceptance_rate <= 100)
    ,is_superhost BOOLEAN
    ,neighborhood VARCHAR
    ,listings_count INT
    ,total_listings_count INT
    ,email_verified BOOLEAN
    ,phone_verified BOOLEAN
    ,has_profile_pic BOOLEAN
    ,identity_verified BOOLEAN
);


-- @block create reviews table
DROP TABLE IF EXISTS reviews;
CREATE TABLE IF NOT EXISTS reviews (
    id SERIAL PRIMARY KEY
    ,number_of_reviews INT
    ,first_review DATE
    ,last_review DATE
    ,reviews_per_month NUMERIC(4,2)
    ,rating_score NUMERIC(4,2)
    ,accuracy_score NUMERIC(4,2)
    ,cleanliness_score NUMERIC(4,2)
    ,checkin_score NUMERIC(4,2)
    ,communication_score NUMERIC(4,2)
    ,location_score NUMERIC(4,2)
    ,value_score NUMERIC(4,2)
);


-- @block create listing table
DROP TABLE IF EXISTS listings;
CREATE TABLE IF NOT EXISTS listings (
    id SERIAL PRIMARY KEY
    ,listing_url VARCHAR
    ,name VARCHAR
    ,description TEXT
    ,property_type VARCHAR
    ,room_type VARCHAR
    ,accommodates INT
    ,bathrooms_text VARCHAR
    ,bedrooms NUMERIC(3,1)
    ,beds NUMERIC(3,1)
    ,amenities TEXT
    ,price NUMERIC(6,1)
    ,minimum_nights INT
    ,maximum_nights INT
    ,host_id INT
    ,location_id INT
    ,reviews_id INT
);


-- @block define relationships
ALTER TABLE listings
    ADD CONSTRAINT fk_host_id FOREIGN KEY (host_id) REFERENCES host(id);
ALTER TABLE listings   
    ADD CONSTRAINT fk_location_id FOREIGN KEY (location_id) REFERENCES location(id);
ALTER TABLE listings
    ADD CONSTRAINT fk_reviews_id FOREIGN KEY (reviews_id) REFERENCES reviews(id);
