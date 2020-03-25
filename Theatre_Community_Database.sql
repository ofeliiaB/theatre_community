

CREATE TABLE `customer` (
    `id` int  NOT NULL ,
    `name` VARCHAR(60)  NOT NULL ,
    `social_security` VARCHAR(60)  NOT NULL ,
    `phone_number` VARCHAR(60)  NOT NULL ,
    `email` VARCHAR(250)  NOT NULL ,
    `address` VARCHAR(60)  NOT NULL ,
    `zipcode` VARCHAR(60)  NOT NULL ,
    `is_corporate` Boolean  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `friends` (
    `id` int  NOT NULL ,
    `customer_id` int  NOT NULL ,
    `date_of_join` DATE  NOT NULL ,
    `payment_info` VARCHAR(60)  NOT NULL ,
    `membership_number` int  NOT NULL ,
    `subscription_status` ENUM  NOT NULL ,
    `is_paid` BOOLEAN  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `companies` (
    `id` int  NOT NULL ,
    `name` VARCHAR(60)  NOT NULL ,
    `phone_number` VARCHAR(60)  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `sponsors` (
    `id` int  NOT NULL ,
    `customer_id` int  NOT NULL ,
    `company_id` int  NOT NULL ,
    `sponsorship_number` int  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `donations` (
    `id` int  NOT NULL ,
    `amount` float  NOT NULL ,
    `date_of_donation` DATETIME  NOT NULL ,
    `sponsor_id` int  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `play` (
    `id` int  NOT NULL ,
    `name` VARCHAR(60)  NOT NULL ,
    `author_name` VARCHAR(60)  NOT NULL ,
    `author_surname` VARCHAR(60)  NOT NULL ,
    `genre` ENUM  NOT NULL ,
    `type_of_residence` ENUM  NOT NULL ,
    `startdate` DATE  NOT NULL ,
    `enddate` DATE  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `seats` (
    `id` int  NOT NULL ,
    `seat_number` VARCHAR(20)  NOT NULL ,
    `hall_number` VARCHAR(20)  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `booking` (
    `id` int  NOT NULL ,
    `customer_id` int  NOT NULL ,
    `play_id` int  NOT NULL ,
    `number_of_seats` TINYINT  NOT NULL ,
    `date_of_booking` DATE  NOT NULL ,
    `booking_method` ENUM  NOT NULL ,
    `booking_for_date` DATETIME  NOT NULL ,
    `is_discount` BOOLEAN  NOT NULL ,
    `is_paid` BOOLEAN  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `tickets` (
    `id` int  NOT NULL ,
    `seats_id` int  NOT NULL ,
    `play_id` int  NOT NULL ,
    `performance_time` DATETIME  NOT NULL ,
    `is_available` BOOLEAN  NOT NULL ,
    `baseprice` float  NOT NULL ,
    `is_returned` BOOLEAN  NOT NULL ,
    `booking_id` int  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `payments` (
    `id` int  NOT NULL ,
    `booking_id` int  NOT NULL ,
    `payment_method` ENUM  NOT NULL ,
    `payment_info` VARCHAR(60)  NOT NULL ,
    `amount_paid` float  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `resold` (
    `id` int  NOT NULL ,
    `ticket_id` int  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `refunds` (
    `id` int  NOT NULL ,
    `resold_id` int  NOT NULL ,
    `customer_id` int  NOT NULL ,
    `payments_id` int  NOT NULL ,
    `amount_refunded` FLOAT  NOT NULL ,
    `is_done` BOOLEAN  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `rads_play` (
    `id` int  NOT NULL ,
    `title` VARCHAR(60)  NOT NULL ,
    `author_name` VARCHAR(20)  NOT NULL ,
    `author_surname` VARCHAR(20)  NOT NULL ,
    `length` VARCHAR(60)  NOT NULL ,
    `number_of_actors` TINYINT  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `roles` (
    `id` int  NOT NULL ,
    `rads_play_id` int  NOT NULL ,
    `role_name` Varchar(60)  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `rads_member` (
    `id` int  NOT NULL ,
    `customer_id` int  NOT NULL ,
    `date_of_join` DATETIME  NOT NULL ,
    `payment_info` VARCHAR(60)  NOT NULL ,
    `type_of_membership` ENUM  NOT NULL ,
    `did_pay_membership` BOOLEAN  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `member_role_per_trip` (
    `rads_member_id` int  NOT NULL ,
    `role_name_id` int  NOT NULL ,
    `trip_id` int  NOT NULL
);

CREATE TABLE `rads_trip` (
    `id` int  NOT NULL ,
    `zipcode_city` VARCHAR(60)  NOT NULL ,
    `cost` FLOAT  NOT NULL ,
    `date` DATE  NOT NULL ,
    `rads_theatre_id` int  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `member_trip` (
    `member_id` int  NOT NULL ,
    `trip_id` int  NOT NULL ,
    `has_paid` BOOLEAN  NOT NULL
);

CREATE TABLE `rads_theatre` (
    `id` int  NOT NULL ,
    `theatre_name` VARCHAR(60)  NOT NULL ,
    `facilities` BOOLEAN  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `rads_production` (
    `id` int  NOT NULL ,
    `venue` VARCHAR(60)  NOT NULL ,
    `director` int  NOT NULL ,
    `date_of_first` DATETIME  NOT NULL ,
    `startdate` DATETIME  NOT NULL ,
    `enddate` DATETIME  NOT NULL ,
    `theatre_id` int  NOT NULL ,
    `rads_play_id` int  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

ALTER TABLE `friends` ADD CONSTRAINT `fk_friends_customer_id` FOREIGN KEY(`customer_id`)
REFERENCES `customer` (`id`);

ALTER TABLE `sponsors` ADD CONSTRAINT `fk_sponsors_customer_id` FOREIGN KEY(`customer_id`)
REFERENCES `customer` (`id`);

ALTER TABLE `sponsors` ADD CONSTRAINT `fk_sponsors_company_id` FOREIGN KEY(`company_id`)
REFERENCES `companies` (`id`);

ALTER TABLE `donations` ADD CONSTRAINT `fk_donations_sponsor_id` FOREIGN KEY(`sponsor_id`)
REFERENCES `sponsors` (`id`);

ALTER TABLE `booking` ADD CONSTRAINT `fk_booking_customer_id` FOREIGN KEY(`customer_id`)
REFERENCES `customer` (`id`);

ALTER TABLE `booking` ADD CONSTRAINT `fk_booking_play_id` FOREIGN KEY(`play_id`)
REFERENCES `play` (`id`);

ALTER TABLE `tickets` ADD CONSTRAINT `fk_tickets_seats_id` FOREIGN KEY(`seats_id`)
REFERENCES `seats` (`id`);

ALTER TABLE `tickets` ADD CONSTRAINT `fk_tickets_play_id` FOREIGN KEY(`play_id`)
REFERENCES `play` (`id`);

ALTER TABLE `tickets` ADD CONSTRAINT `fk_tickets_booking_id` FOREIGN KEY(`booking_id`)
REFERENCES `booking` (`id`);

ALTER TABLE `payments` ADD CONSTRAINT `fk_payments_booking_id` FOREIGN KEY(`booking_id`)
REFERENCES `booking` (`id`);

ALTER TABLE `resold` ADD CONSTRAINT `fk_resold_ticket_id` FOREIGN KEY(`ticket_id`)
REFERENCES `tickets` (`id`);

ALTER TABLE `refunds` ADD CONSTRAINT `fk_refunds_resold_id` FOREIGN KEY(`resold_id`)
REFERENCES `resold` (`id`);

ALTER TABLE `refunds` ADD CONSTRAINT `fk_refunds_customer_id` FOREIGN KEY(`customer_id`)
REFERENCES `customer` (`id`);

ALTER TABLE `refunds` ADD CONSTRAINT `fk_refunds_payments_id` FOREIGN KEY(`payments_id`)
REFERENCES `payments` (`id`);

ALTER TABLE `roles` ADD CONSTRAINT `fk_roles_rads_play_id` FOREIGN KEY(`rads_play_id`)
REFERENCES `rads_play` (`id`);

ALTER TABLE `rads_member` ADD CONSTRAINT `fk_rads_member_customer_id` FOREIGN KEY(`customer_id`)
REFERENCES `customer` (`id`);

ALTER TABLE `member_role_per_trip` ADD CONSTRAINT `fk_member_role_per_trip_rads_member_id` FOREIGN KEY(`rads_member_id`)
REFERENCES `rads_member` (`id`);

ALTER TABLE `member_role_per_trip` ADD CONSTRAINT `fk_member_role_per_trip_role_name_id` FOREIGN KEY(`role_name_id`)
REFERENCES `roles` (`id`);

ALTER TABLE `member_role_per_trip` ADD CONSTRAINT `fk_member_role_per_trip_trip_id` FOREIGN KEY(`trip_id`)
REFERENCES `rads_trip` (`id`);

ALTER TABLE `rads_trip` ADD CONSTRAINT `fk_rads_trip_rads_theatre_id` FOREIGN KEY(`rads_theatre_id`)
REFERENCES `rads_theatre` (`id`);

ALTER TABLE `member_trip` ADD CONSTRAINT `fk_member_trip_member_id` FOREIGN KEY(`member_id`)
REFERENCES `rads_member` (`id`);

ALTER TABLE `member_trip` ADD CONSTRAINT `fk_member_trip_trip_id` FOREIGN KEY(`trip_id`)
REFERENCES `rads_trip` (`id`);

ALTER TABLE `rads_production` ADD CONSTRAINT `fk_rads_production_director` FOREIGN KEY(`director`)
REFERENCES `rads_member` (`id`);

ALTER TABLE `rads_production` ADD CONSTRAINT `fk_rads_production_theatre_id` FOREIGN KEY(`theatre_id`)
REFERENCES `rads_theatre` (`id`);

ALTER TABLE `rads_production` ADD CONSTRAINT `fk_rads_production_rads_play_id` FOREIGN KEY(`rads_play_id`)
REFERENCES `rads_play` (`id`);
