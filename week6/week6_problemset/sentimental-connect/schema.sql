CREATE TABLE users (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `first_name` VARCHAR(20) NOT NULL,
    `last_name` VARCHAR(32) NOT NULL,
    `username` VARCHAR(15) NOT NULL,
    `password` VARCHAR(128) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE schools (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(60) NOT NULL,
    `type` ENUM('Primary', 'Secondary', 'Higher Education') NOT NULL,
    `year` YEAR NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE companies (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `industry` ENUM('Technology', 'Education', 'Business') NOT NULL,
    `location` VARCHAR(100) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE user_connections (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `first_user_id` INT UNSIGNED,
    `second_user_id` INT UNSIGNED,
    PRIMARY KEY(id),
    FOREIGN KEY(first_user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(second_user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE school_affiliations (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `user_id` INT UNSIGNED,
    `school_id` INT UNSIGNED,
    `start_date` DATE NOT NULL,
    `end_date` DATE DEFAULT NULL,
    `degree` VARCHAR(5) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(school_id) REFERENCES schools(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE company_affiliations (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `user_id` INT UNSIGNED,
    `company_id` INT UNSIGNED,
    `start_date` DATE NOT NULL,
    `end_date` DATE DEFAULT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(`company_id`) REFERENCES `companies`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);
