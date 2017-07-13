SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `myblog` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `myblog` ;

-- -----------------------------------------------------
-- Table `myblog`.`articles`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `myblog`.`articles` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(45) NOT NULL COMMENT 'Заголовок статьи' ,
  `text` TEXT NOT NULL COMMENT 'Текст статьи' ,
  `date` TIMESTAMP NOT NULL DEFAULT now() COMMENT 'Дата добавления статьи.' ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `myblog`.`users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `myblog`.`users` (
  `login` VARCHAR(15) NOT NULL COMMENT 'Логин' ,
  `pass` VARCHAR(45) NOT NULL COMMENT 'Пароль' ,
  PRIMARY KEY (`login`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `myblog`.`groupuser`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `myblog`.`groupuser` (
  `name` VARCHAR(20) NOT NULL COMMENT 'Наименование группы' ,
  `users_login` VARCHAR(15) NOT NULL COMMENT 'Вторичный ключ от таблицы users' ,
  PRIMARY KEY (`name`) ,
  INDEX `fk_groupuser_users` (`users_login` ASC) ,
  CONSTRAINT `fk_groupuser_users`
    FOREIGN KEY (`users_login` )
    REFERENCES `myblog`.`users` (`login` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `myblog`.`messages`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `myblog`.`messages` (
  `id` INT NOT NULL ,
  `text` VARCHAR(255) NOT NULL COMMENT 'Текст сообщения' ,
  `date` TIMESTAMP NOT NULL DEFAULT now() COMMENT 'Дата мессаги' ,
  `users_login` VARCHAR(15) NOT NULL COMMENT 'Юзер пославший мессагу' ,
  `articles_id` INT NOT NULL COMMENT 'Статье к которой послан комент' ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_messages_users1` (`users_login` ASC) ,
  INDEX `fk_messages_articles1` (`articles_id` ASC) ,
  CONSTRAINT `fk_messages_users1`
    FOREIGN KEY (`users_login` )
    REFERENCES `myblog`.`users` (`login` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_articles1`
    FOREIGN KEY (`articles_id` )
    REFERENCES `myblog`.`articles` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `myblog`.`groupuser_has_articles`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `myblog`.`groupuser_has_articles` (
  `groupuser_name` VARCHAR(20) NOT NULL ,
  `articles_id` INT NOT NULL ,
  PRIMARY KEY (`groupuser_name`, `articles_id`) ,
  INDEX `fk_groupuser_has_articles_articles1` (`articles_id` ASC) ,
  INDEX `fk_groupuser_has_articles_groupuser1` (`groupuser_name` ASC) ,
  CONSTRAINT `fk_groupuser_has_articles_groupuser1`
    FOREIGN KEY (`groupuser_name` )
    REFERENCES `myblog`.`groupuser` (`name` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_groupuser_has_articles_articles1`
    FOREIGN KEY (`articles_id` )
    REFERENCES `myblog`.`articles` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
