CREATE TABLE Users(
    UserID int NOT NULL AUTO_INCREMENT,
    Username varchar(255) NOT NULL,
    Location varchar(255) NOT NULL,
    Telephone int NOT NULL,
    Balance int DEFAULT 0,
    Password char(64) NOT NULL,
    PRIMARY KEY (UserID),
    UNIQUE(User_ID)
);


CREATE TABLE Posts(
    PostID int NOT NULL AUTO_INCREMENT,
    UserID varchar(255),
    Title varchar(64) NOT NULL,
    Description varchar(512) NOT NULL,
    Price int NOT NULL,
    Delivery BIT DEFAULT 0,
    Location varchar(255) NOT NULL,
    PricePerKM int NOT NULL,
    PRIMARY KEY (PostID),
    CONSTRAINT user_fk FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE
    
);


CREATE TABLE Orders(
    OrderID int NOT NULL AUTO_INCREMENT,
    PostID int NOT NULL,
    UserID int NOT NULL,
    Price int,
    Qty int,
    PRIMARY KEY (Orders),
    CONSTRAINT userid_fk FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT postid_fk FOREIGN KEY (PostID) REFERENCES Posts(PostID) ON DELETE CASCADE ON UPDATE CASCADE
);