-- MySQL Script generated by MySQL Workbench
-- Sun Jul  7 20:48:25 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`ranks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ranks` (
  `ranksID` INT NOT NULL,
  `function` BLOB NULL,
  PRIMARY KEY (`ranksID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rank` (
  `rankID` INT NOT NULL AUTO_INCREMENT,
  `ranksID` INT NULL,
  `icon` VARCHAR(10) NULL,
  `title` VARCHAR(45) NULL,
  `pointRange` INT NULL,
  PRIMARY KEY (`rankID`),
  INDEX `fk_rank_ranks1_idx` (`ranksID` ASC),
  CONSTRAINT `fk_rank_ranks1`
    FOREIGN KEY (`ranksID`)
    REFERENCES `mydb`.`ranks` (`ranksID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`leaderBoard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`leaderBoard` (
  `leaderBoardID` INT NOT NULL AUTO_INCREMENT,
  `userID` INT NULL,
  `rankIcon` VARCHAR(45) NULL,
  `rankPoint` INT NULL,
  `rankTitle` VARCHAR(45) NULL,
  PRIMARY KEY (`leaderBoardID`),
  UNIQUE INDEX `leaderBoardID_UNIQUE` (`leaderBoardID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`meeting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`meeting` (
  `meetingID` VARCHAR(45) NOT NULL,
  `meetinTitle` VARCHAR(45) NULL,
  `meetingDate` DATE NULL,
  `meetingInvitess` BLOB NULL,
  PRIMARY KEY (`meetingID`),
  UNIQUE INDEX `meetingcol_UNIQUE` (`meetingID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`paymentInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`paymentInfo` (
  `paymentID` INT NOT NULL AUTO_INCREMENT,
  `cardNumber` INT NOT NULL,
  `cardName` VARCHAR(45) NOT NULL,
  `zipCode` INT NOT NULL,
  `backCode` INT NOT NULL,
  PRIMARY KEY (`paymentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `username` VARCHAR(64) NOT NULL,
  `membershiType` VARCHAR(45) NULL,
  `email` VARCHAR(128) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `point` INT NULL,
  `rankID` INT NULL,
  `leaderBoardID` INT NULL,
  `meetingID` VARCHAR(45) NULL,
  `paymentInfo_paymentID` INT NULL,
  `challengesCompleted` VARCHAR(45) NULL,
  `numChallengesCompleted` VARCHAR(100) NULL,
  `allTrophies` BLOB NULL,
  `streakChallengesCompleted` VARCHAR(45) NULL,
  `coins` INT NULL,
  `mentees` VARCHAR(45) NULL,
  `notificationList` BLOB NULL,
  `bookmarks` VARCHAR(45) NULL,
  `numPosts` VARCHAR(45) NULL,
  `groups` BLOB NULL,
  `groupsMentored` BLOB NULL,
  `profile` BLOB NULL,
  `isPremium` TINYINT NULL,
  `isMentor` TINYINT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `userID_UNIQUE` (`userID` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `password_UNIQUE` (`password` ASC),
  INDEX `fk_user_ranksClass1_idx` (`rankID` ASC),
  INDEX `fk_user_leader Board1_idx` (`leaderBoardID` ASC),
  INDEX `fk_user_meeting1_idx` (`meetingID` ASC),
  INDEX `fk_user_paymentInfo1_idx` (`paymentInfo_paymentID` ASC),
  CONSTRAINT `rankID`
    FOREIGN KEY (`rankID`)
    REFERENCES `mydb`.`rank` (`rankID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `leaderBoardID`
    FOREIGN KEY (`leaderBoardID`)
    REFERENCES `mydb`.`leaderBoard` (`leaderBoardID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_meeting1`
    FOREIGN KEY (`meetingID`)
    REFERENCES `mydb`.`meeting` (`meetingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_paymentInfo1`
    FOREIGN KEY (`paymentInfo_paymentID`)
    REFERENCES `mydb`.`paymentInfo` (`paymentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`portfolio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`portfolio` (
  `portfolioID` INT NOT NULL AUTO_INCREMENT,
  `userID` INT NOT NULL,
  `porjects` VARCHAR(45) NULL,
  `visability` VARCHAR(45) NULL,
  PRIMARY KEY (`portfolioID`),
  UNIQUE INDEX `portfolioID` (`portfolioID` ASC),
  INDEX `userID` (`userID` ASC) VISIBLE,
  CONSTRAINT `userID`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`notification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`notification` (
  `notificationID` INT NOT NULL,
  `title` VARCHAR(45) NULL,
  `redirectedLink` VARCHAR(45) NULL,
  `date` DATE NULL,
  `time` TIME NULL,
  PRIMARY KEY (`notificationID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`userNotification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`userNotification` (
  `userNotificationID` INT NOT NULL,
  `notificationID` INT NOT NULL,
  `userID` INT NOT NULL,
  INDEX `fk_notification_has_user_user1_idx` (`userID` ASC),
  INDEX `fk_notification_has_user_notification1_idx` (`notificationID` ASC),
  PRIMARY KEY (`userNotificationID`),
  CONSTRAINT `fk_notification_has_user_notification1`
    FOREIGN KEY (`notificationID`)
    REFERENCES `mydb`.`notification` (`notificationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notification_has_user_user1`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`project` (
  `projectID` INT NOT NULL AUTO_INCREMENT,
  `portfolioID` INT NULL,
  `projectLink` VARCHAR(45) NULL,
  `projectDesc` VARCHAR(45) NULL,
  `projectTitle` VARCHAR(45) NULL,
  `projectPics` VARCHAR(45) NULL,
  PRIMARY KEY (`projectID`),
  INDEX `portfolioID` (`portfolioID` ASC),
  CONSTRAINT `portfolioID`
    FOREIGN KEY (`portfolioID`)
    REFERENCES `mydb`.`portfolio` (`portfolioID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`jobList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`jobList` (
  `jobID` INT NOT NULL AUTO_INCREMENT,
  `jobTitle` VARCHAR(45) NULL,
  `jobCompany` VARCHAR(45) NULL,
  `jobLocation` VARCHAR(45) NULL,
  `jobDescription` VARCHAR(45) NULL,
  `jobRequirements` VARCHAR(45) NULL,
  `jobDate` DATETIME NULL,
  `jobLink` VARCHAR(45) NULL,
  PRIMARY KEY (`jobID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`userView`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`userView` (
  `userViewID` INT NOT NULL,
  `userID` INT NULL,
  `jobID` INT NOT NULL,
  PRIMARY KEY (`userViewID`),
  INDEX `fk_user_has_jobList_jobList1_idx` (`jobID` ASC),
  INDEX `fk_user_has_jobList_user1_idx` (`userID` ASC),
  CONSTRAINT `userID`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `jobID`
    FOREIGN KEY (`jobID`)
    REFERENCES `mydb`.`jobList` (`jobID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`forumThread`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`forumThread` (
  `threadID` INT NOT NULL,
  `originalPoster` VARCHAR(45) NULL,
  `threadTitle` VARCHAR(45) NULL,
  `posts` VARCHAR(45) NULL,
  `date` DATETIME NULL,
  `time` TIME NULL,
  PRIMARY KEY (`threadID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`post` (
  `userID` INT NOT NULL,
  `postID` INT NOT NULL,
  `content` VARCHAR(45) NULL,
  `comments` VARCHAR(45) NULL,
  `codeBlock` BLOB NULL,
  `date` DATE NULL,
  `time` TIME NULL,
  `likes` INT NULL,
  `threadID` INT NOT NULL,
  PRIMARY KEY (`postID`),
  INDEX `fk_forumPost_user1_idx` (`userID` ASC),
  INDEX `fk_post_forumThread1_idx` (`threadID` ASC),
  CONSTRAINT `userID`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_forumThread1`
    FOREIGN KEY (`threadID`)
    REFERENCES `mydb`.`forumThread` (`threadID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`trophy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`trophy` (
  `trophyID` INT NOT NULL AUTO_INCREMENT,
  `trophyName` VARCHAR(45) NULL,
  `trophyDescription` VARCHAR(45) NULL,
  `trophyflag` TINYINT NULL,
  `userID` INT NOT NULL,
  PRIMARY KEY (`trophyID`),
  INDEX `fk_trophy_user1_idx` (`userID` ASC),
  CONSTRAINT `userID`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`codingChallenge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`codingChallenge` (
  `title` VARCHAR(45) NULL,
  `challengeID` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  `language` VARCHAR(45) NULL,
  `codingDifficulty` VARCHAR(45) NULL,
  `codingBlock` VARCHAR(45) NULL,
  `deadline` VARCHAR(45) NULL,
  `completionPoints` INT NULL,
  `solutions` VARCHAR(45) NULL,
  `codingTests` VARCHAR(45) NULL,
  `pseudocodeHint` VARCHAR(45) NULL,
  PRIMARY KEY (`challengeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`challengeSub`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`challengeSub` (
  `challengeSubID` INT NOT NULL,
  `userID` INT NOT NULL,
  `codingID` INT NOT NULL,
  `codeSub` VARCHAR(45) NULL,
  `date` DATE NULL,
  `time` TIME NULL,
  `verifiedSolution` TINYINT NULL,
  PRIMARY KEY (`challengeSubID`),
  INDEX `fk_challengeSub_user1_idx` (`userID` ASC),
  INDEX `fk_challengeSub_codingChallenge1_idx` (`codingID` ASC),
  CONSTRAINT `userID`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_challengeSub_codingChallenge1`
    FOREIGN KEY (`codingID`)
    REFERENCES `mydb`.`codingChallenge` (`challengeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`userChallenge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`userChallenge` (
  `userChallengeID` INT NOT NULL,
  `challengeID` INT NULL,
  `userID` INT NULL,
  PRIMARY KEY (`userChallengeID`),
  INDEX `fk_codingChallenge_has_user_user1_idx` (`userID` ASC),
  INDEX `fk_codingChallenge_has_user_codingChallenge1_idx` (`challengeID` ASC),
  CONSTRAINT `codingID`
    FOREIGN KEY (`challengeID`)
    REFERENCES `mydb`.`codingChallenge` (`challengeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `userID`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`submissionShare`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`submissionShare` (
  `shareID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `userID` INT NOT NULL,
  `like` TINYINT NULL,
  `comments` TINYINT NULL,
  PRIMARY KEY (`shareID`),
  INDEX `fk_challengePost_user1_idx` (`userID` ASC),
  CONSTRAINT `userID`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`premiumUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`premiumUser` (
  `userID` INT NOT NULL,
  INDEX `userID` (`userID` ASC),
  PRIMARY KEY (`userID`),
  CONSTRAINT `userID`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mentorUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mentorUser` (
  `userID` INT NOT NULL,
  INDEX `fk_mentorUser_premiumUser1_idx` (`userID` ASC),
  PRIMARY KEY (`userID`),
  CONSTRAINT `fk_mentorUser_premiumUser1`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`premiumUser` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`feedback` (
  `feedbackID` INT NOT NULL,
  `userID` INT NULL,
  `challengeSubID` INT NOT NULL,
  `solutionSubmission` VARCHAR(45) NULL,
  `organizationFeedback` VARCHAR(45) NULL,
  `organizationScore` INT NULL,
  `logicFeedback` VARCHAR(45) NULL,
  `logicScore` INT NULL,
  `commentFeedback` VARCHAR(45) NULL,
  `commentScore` INT NULL,
  PRIMARY KEY (`feedbackID`),
  INDEX `fk_feedback_mentorUser1_idx` (`userID` ASC),
  INDEX `fk_feedback_challengeSub1_idx` (`challengeSubID` ASC),
  CONSTRAINT `fk_feedback_mentorUser1`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`mentorUser` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_feedback_challengeSub1`
    FOREIGN KEY (`challengeSubID`)
    REFERENCES `mydb`.`challengeSub` (`challengeSubID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`inbox`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`inbox` (
  `userID` INT NOT NULL,
  INDEX `userID` (`userID` ASC),
  CONSTRAINT `userID`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`messageThread`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`messageThread` (
  `messageThreadID` INT NOT NULL,
  PRIMARY KEY (`messageThreadID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`message` (
  `messageID` INT NOT NULL,
  `userID` INT NULL,
  `receivingUsers` VARCHAR(45) NULL,
  `time` TIME NULL,
  `date` DATE NULL,
  `content` VARCHAR(45) NULL,
  `inbox_userID` INT NOT NULL,
  `messageThreadID` INT NOT NULL,
  PRIMARY KEY (`messageID`),
  INDEX `fk_message_user1_idx` (`userID` ASC),
  INDEX `fk_message_inbox1_idx` (`inbox_userID` ASC),
  INDEX `fk_message_messageThread1_idx` (`messageThreadID` ASC),
  CONSTRAINT `userID`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_inbox1`
    FOREIGN KEY (`inbox_userID`)
    REFERENCES `mydb`.`inbox` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_messageThread1`
    FOREIGN KEY (`messageThreadID`)
    REFERENCES `mydb`.`messageThread` (`messageThreadID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`externalLinks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`externalLinks` (
  `externalLinksID` INT NOT NULL,
  `xLogo` VARCHAR(45) NULL,
  `linkedinLogo` VARCHAR(45) NULL,
  `instagramLogo` VARCHAR(45) NULL,
  `tiktokLogo` VARCHAR(45) NULL,
  `facebookLogo` VARCHAR(45) NULL,
  `xLink` VARCHAR(45) NULL,
  `linkedinLink` VARCHAR(45) NULL,
  `instagramLink` VARCHAR(45) NULL,
  `tiktokLink` VARCHAR(45) NULL,
  `facebookLink` VARCHAR(45) NULL,
  `hasX` TINYINT NULL,
  `hasLinkedin` TINYINT NULL,
  `hasInstagram` TINYINT NULL,
  `hasTiktok` TINYINT NULL,
  `hasFacebook` TINYINT NULL,
  PRIMARY KEY (`externalLinksID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`profile` (
  `profileID` INT NOT NULL,
  `userID` INT NOT NULL,
  `isMentor` TINYINT NULL,
  `biography` VARCHAR(45) NULL,
  `portfolioID` INT NULL,
  `externalLinksID` INT NOT NULL,
  PRIMARY KEY (`profileID`),
  INDEX `userID` (`userID` ASC),
  INDEX `fk_profile_portfolio1_idx` (`portfolioID` ASC),
  INDEX `fk_profile_externalLinks1_idx` (`externalLinksID` ASC),
  CONSTRAINT `userID`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profile_portfolio1`
    FOREIGN KEY (`portfolioID`)
    REFERENCES `mydb`.`portfolio` (`portfolioID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profile_externalLinks1`
    FOREIGN KEY (`externalLinksID`)
    REFERENCES `mydb`.`externalLinks` (`externalLinksID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`groups` (
  `groupsID` INT NOT NULL,
  `mentorGroupsList` VARCHAR(45) NULL,
  `groupsList` VARCHAR(45) NULL,
  PRIMARY KEY (`groupsID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`group` (
  `groupID` INT NOT NULL,
  `forum` BLOB NULL,
  `groupsID` INT NOT NULL,
  PRIMARY KEY (`groupID`),
  INDEX `fk_group_groups1_idx` (`groupsID` ASC),
  CONSTRAINT `fk_group_groups1`
    FOREIGN KEY (`groupsID`)
    REFERENCES `mydb`.`groups` (`groupsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`userGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`userGroup` (
  `userGroupID` VARCHAR(45) NOT NULL,
  `userID` INT NOT NULL,
  `groupID` INT NOT NULL,
  PRIMARY KEY (`userGroupID`),
  INDEX `fk_user_has_group_group1_idx` (`groupID` ASC),
  INDEX `fk_user_has_group_user1_idx` (`userID` ASC),
  CONSTRAINT `fk_user_has_group_user1`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_group_group1`
    FOREIGN KEY (`groupID`)
    REFERENCES `mydb`.`group` (`groupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mentorGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mentorGroup` (
  `groupID` INT NOT NULL,
  `groupsID` INT NOT NULL,
  INDEX `fk_mentorGroup_group1_idx` (`groupID` ASC),
  PRIMARY KEY (`groupID`),
  INDEX `fk_mentorGroup_groups1_idx` (`groupsID` ASC),
  CONSTRAINT `fk_mentorGroup_group1`
    FOREIGN KEY (`groupID`)
    REFERENCES `mydb`.`group` (`groupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mentorGroup_groups1`
    FOREIGN KEY (`groupsID`)
    REFERENCES `mydb`.`groups` (`groupsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`userMentorGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`userMentorGroup` (
  `mentorGroup_has_mentorUserID` INT NOT NULL,
  `groupID` INT NOT NULL,
  `userID` INT NOT NULL,
  PRIMARY KEY (`mentorGroup_has_mentorUserID`),
  INDEX `fk_mentorGroup_has_mentorUser_mentorUser1_idx` (`userID` ASC),
  INDEX `fk_mentorGroup_has_mentorUser_mentorGroup1_idx` (`groupID` ASC),
  CONSTRAINT `fk_mentorGroup_has_mentorUser_mentorGroup1`
    FOREIGN KEY (`groupID`)
    REFERENCES `mydb`.`mentorGroup` (`groupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mentorGroup_has_mentorUser_mentorUser1`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`mentorUser` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`forum`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`forum` (
  `forumID` INT NOT NULL,
  `threadID` INT NOT NULL,
  `threadTitle` VARCHAR(45) NULL,
  `date` DATE NULL,
  `time` TIME NULL,
  `listMember` BLOB NULL,
  `threads` BLOB NULL,
  PRIMARY KEY (`forumID`),
  INDEX `fk_forum_forumThread1_idx` (`threadID` ASC),
  CONSTRAINT `fk_forum_forumThread1`
    FOREIGN KEY (`threadID`)
    REFERENCES `mydb`.`forumThread` (`threadID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`specificTrophy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`specificTrophy` (
  `trophyID` INT NOT NULL,
  `hasTrophy` TINYINT NULL,
  INDEX `fk_specificTrophy_trophy1_idx` (`trophyID` ASC),
  PRIMARY KEY (`trophyID`),
  CONSTRAINT `fk_specificTrophy_trophy1`
    FOREIGN KEY (`trophyID`)
    REFERENCES `mydb`.`trophy` (`trophyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`userHiring`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`userHiring` (
  `userID` INT NOT NULL,
  `company` VARCHAR(45) NULL,
  `position` VARCHAR(45) NULL,
  INDEX `fk_userHiring_user1_idx` (`userID` ASC),
  PRIMARY KEY (`userID`),
  CONSTRAINT `fk_userHiring_user1`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`supportForm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`supportForm` (
  `supportFormID` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `date` DATE NULL,
  `time` TIME NULL,
  `message` VARCHAR(45) NULL,
  `userID` INT NOT NULL,
  `userHiring_userID` INT NOT NULL,
  PRIMARY KEY (`supportFormID`),
  INDEX `fk_supportForm_user1_idx` (`userID` ASC),
  INDEX `fk_supportForm_userHiring1_idx` (`userHiring_userID` ASC),
  CONSTRAINT `fk_supportForm_user1`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_supportForm_userHiring1`
    FOREIGN KEY (`userHiring_userID`)
    REFERENCES `mydb`.`userHiring` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`chatbot`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`chatbot` (
  `chatbotID` INT NOT NULL,
  `userID` INT NOT NULL,
  `supportFormID` INT NOT NULL,
  PRIMARY KEY (`chatbotID`),
  INDEX `fk_chatbot_userHiring1_idx` (`userID` ASC),
  INDEX `fk_chatbot_supportForm1_idx` (`supportFormID` ASC),
  CONSTRAINT `fk_chatbot_userHiring1`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`userHiring` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_chatbot_supportForm1`
    FOREIGN KEY (`supportFormID`)
    REFERENCES `mydb`.`supportForm` (`supportFormID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
