SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema GridDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema GridDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `GridDB` DEFAULT CHARACTER SET utf8 ;
USE `GridDB` ;

-- -----------------------------------------------------
-- Table `GridDB`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`users` (
                                                `id` INT NOT NULL AUTO_INCREMENT,
                                                `email` VARCHAR(255) NOT NULL,
    `username` VARCHAR(100) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `roles` VARCHAR(255) NOT NULL,
    `balance` DECIMAL NOT NULL DEFAULT 0,
    `first_name` VARCHAR(100) NULL,
    `last_name` VARCHAR(100) NULL,
    `date_of_birth` DATETIME NULL,
    `avatar_url` TEXT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`developers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`developers` (
                                                     `developer_id` INT NOT NULL AUTO_INCREMENT,
                                                     `name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`developer_id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`publishers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`publishers` (
                                                     `publisher_id` INT NOT NULL AUTO_INCREMENT,
                                                     `name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`publisher_id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`games`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`games` (
                                                `game_id` INT NOT NULL AUTO_INCREMENT,
                                                `title` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `release_date` DATE NULL,
    `system_requirements` TEXT NULL,
    `price` DECIMAL(10,2) NULL,
    `cover_image_url` TEXT NULL,
    `developer_id` INT NOT NULL,
    `publisher_id` INT NOT NULL,
    PRIMARY KEY (`game_id`),
    INDEX `fk_games_developers1_idx` (`developer_id` ASC) VISIBLE,
    INDEX `fk_games_publishers1_idx` (`publisher_id` ASC) VISIBLE,
    CONSTRAINT `fk_games_developers1`
    FOREIGN KEY (`developer_id`)
    REFERENCES `GridDB`.`developers` (`developer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_games_publishers1`
    FOREIGN KEY (`publisher_id`)
    REFERENCES `GridDB`.`publishers` (`publisher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`users_library`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`users_library` (
                                                        `users_id` INT NOT NULL,
                                                        `games_id` INT NULL,
                                                        `purchase_date` DATETIME NULL,
                                                        `playtime` TIME NULL,
                                                        INDEX `fk_user_library_users_idx` (`users_id` ASC) VISIBLE,
    INDEX `fk_user_library_games1_idx` (`games_id` ASC) VISIBLE,
    PRIMARY KEY (`users_id`),
    CONSTRAINT `fk_user_library_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `GridDB`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_user_library_games1`
    FOREIGN KEY (`games_id`)
    REFERENCES `GridDB`.`games` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`reviews` (
                                                  `review_id` INT NOT NULL AUTO_INCREMENT,
                                                  `users_id` INT NOT NULL,
                                                  `games_id` INT NOT NULL,
                                                  `rating` INT NOT NULL,
                                                  `comment` TEXT NOT NULL,
                                                  `review_date` DATE NOT NULL,
                                                  PRIMARY KEY (`review_id`),
    INDEX `fk_reviews_users1_idx` (`users_id` ASC) VISIBLE,
    INDEX `fk_reviews_games1_idx` (`games_id` ASC) VISIBLE,
    CONSTRAINT `fk_reviews_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `GridDB`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_reviews_games1`
    FOREIGN KEY (`games_id`)
    REFERENCES `GridDB`.`games` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`genres` (
                                                 `genre_id` INT NOT NULL AUTO_INCREMENT,
                                                 `name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`genre_id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`games_has_genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`games_has_genres` (
                                                           `games_id` INT NOT NULL,
                                                           `genres_id` INT NOT NULL,
                                                           INDEX `fk_games_has_genres_genres1_idx` (`genres_id` ASC) VISIBLE,
    INDEX `fk_games_has_genres_games1_idx` (`games_id` ASC) VISIBLE,
    PRIMARY KEY (`games_id`, `genres_id`),
    CONSTRAINT `fk_games_has_genres_games1`
    FOREIGN KEY (`games_id`)
    REFERENCES `GridDB`.`games` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_games_has_genres_genres1`
    FOREIGN KEY (`genres_id`)
    REFERENCES `GridDB`.`genres` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`platforms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`platforms` (
                                                    `platform_id` INT NOT NULL AUTO_INCREMENT,
                                                    `name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`platform_id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`games_has_platforms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`games_has_platforms` (
                                                              `games_id` INT NOT NULL,
                                                              `platforms_id` INT NOT NULL,
                                                              INDEX `fk_games_has_platforms_platforms1_idx` (`platforms_id` ASC) VISIBLE,
    INDEX `fk_games_has_platforms_games1_idx` (`games_id` ASC) VISIBLE,
    PRIMARY KEY (`games_id`, `platforms_id`),
    CONSTRAINT `fk_games_has_platforms_games1`
    FOREIGN KEY (`games_id`)
    REFERENCES `GridDB`.`games` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_games_has_platforms_platforms1`
    FOREIGN KEY (`platforms_id`)
    REFERENCES `GridDB`.`platforms` (`platform_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`developers_has_publishers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`developers_has_publishers` (
                                                                    `developers_id` INT NOT NULL,
                                                                    `publishers_id` INT NOT NULL,
                                                                    INDEX `fk_developers_has_publishers_publishers1_idx` (`publishers_id` ASC) VISIBLE,
    INDEX `fk_developers_has_publishers_developers1_idx` (`developers_id` ASC) VISIBLE,
    PRIMARY KEY (`developers_id`, `publishers_id`),
    CONSTRAINT `fk_developers_has_publishers_developers1`
    FOREIGN KEY (`developers_id`)
    REFERENCES `GridDB`.`developers` (`developer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_developers_has_publishers_publishers1`
    FOREIGN KEY (`publishers_id`)
    REFERENCES `GridDB`.`publishers` (`publisher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`game_medias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`game_medias` (
                                                      `image_id` INT NOT NULL AUTO_INCREMENT,
                                                      `image_url` TEXT NOT NULL,
                                                      `trailer` TEXT NULL,
                                                      `games_id` INT NOT NULL,
                                                      PRIMARY KEY (`image_id`),
    INDEX `fk_game_images_games1_idx` (`games_id` ASC) VISIBLE,
    CONSTRAINT `fk_game_images_games1`
    FOREIGN KEY (`games_id`)
    REFERENCES `GridDB`.`games` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`tags` (
                                               `tag_id` INT NOT NULL AUTO_INCREMENT,
                                               `name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`tag_id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`payment_methods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`payment_methods` (
                                                          `payment_method_id` INT NOT NULL AUTO_INCREMENT,
                                                          `payment_type` ENUM("PAYPAL", "MASTERCARD") NOT NULL,
    PRIMARY KEY (`payment_method_id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`wishlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`wishlist` (
                                                   `wishlist_id` INT NOT NULL,
                                                   `users_id` INT NOT NULL,
                                                   `games_id` INT NOT NULL,
                                                   `added_date` DATE NULL,
                                                   PRIMARY KEY (`wishlist_id`),
    INDEX `fk_users_has_games_games1_idx` (`games_id` ASC) VISIBLE,
    INDEX `fk_users_has_games_users1_idx` (`users_id` ASC) VISIBLE,
    CONSTRAINT `fk_users_has_games_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `GridDB`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_users_has_games_games1`
    FOREIGN KEY (`games_id`)
    REFERENCES `GridDB`.`games` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`transactions` (
                                                       `transaction_id` INT NOT NULL AUTO_INCREMENT,
                                                       `purchase_date` DATETIME NOT NULL,
                                                       `total_amount` DECIMAL NOT NULL,
                                                       `payment_methods_id` INT NOT NULL,
                                                       `users_id` INT NOT NULL,
                                                       PRIMARY KEY (`transaction_id`),
    INDEX `fk_transactions_payment_methods1_idx` (`payment_methods_id` ASC) VISIBLE,
    INDEX `fk_transactions_users1_idx` (`users_id` ASC) VISIBLE,
    CONSTRAINT `fk_transactions_payment_methods1`
    FOREIGN KEY (`payment_methods_id`)
    REFERENCES `GridDB`.`payment_methods` (`payment_method_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_transactions_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `GridDB`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`user_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`user_roles` (
                                                     `users_id` INT NOT NULL,
                                                     `role` ENUM("ADMIN", "USER") NOT NULL,
    PRIMARY KEY (`users_id`),
    CONSTRAINT `fk_table1_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `GridDB`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GridDB`.`games_has_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GridDB`.`games_has_tags` (
                                                         `tags_id` INT NOT NULL,
                                                         `games_id` INT NOT NULL,
                                                         INDEX `fk_games_has_tags_tags1_idx` (`tags_id` ASC) VISIBLE,
    INDEX `fk_games_has_tags_games1_idx` (`games_id` ASC) VISIBLE,
    PRIMARY KEY (`tags_id`, `games_id`),
    CONSTRAINT `fk_games_has_tags_games1`
    FOREIGN KEY (`games_id`)
    REFERENCES `GridDB`.`games` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_games_has_tags_tags1`
    FOREIGN KEY (`tags_id`)
    REFERENCES `GridDB`.`tags` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
