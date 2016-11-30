class CreateTables < ActiveRecord::Migration[5.0]
  def up
    sql =["CREATE TABLE User (
            UserID varchar(7) NOT NULL,
            Nickname varchar(30),
            GradYear int,
            Major varchar(30),
            PRIMARY KEY (UserID)
          )", 
          "CREATE TABLE FriendRequest (
            FromUserID varchar(7) NOT NULL, 
            ToUserID varchar(7) NOT NULL, 
            AcceptanceStatus int NOT NULL,
            PRIMARY KEY (FromUserID, ToUserID),
            FOREIGN KEY (FromUserID)
              REFERENCES User(UserID)
              ON DELETE CASCADE 
              ON UPDATE CASCADE,
            FOREIGN KEY (ToUserID)
              REFERENCES User(UserID)
              ON DELETE CASCADE 
              ON UPDATE CASCADE
          )", 
          "CREATE TABLE IndoorLocation (
            IndoorID varchar(7) NOT NULL,
            Building varchar(50) NOT NULL,
            Floor varchar(50),
            Room varchar(50),
            PRIMARY KEY (IndoorID)
          )",
          "CREATE TABLE Location (
            ID int NOT NULL,
            Description varchar(100) NOT NULL, 
            Latitude float NOT NULL, 
            Longitude float NOT NULL, 
            IndoorID varchar(7),
            CreatorID varchar(7),
            CreateTime datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (ID),
            FOREIGN KEY (IndoorID)
              REFERENCES IndoorLocation(IndoorID)
              ON DELETE CASCADE 
              ON UPDATE CASCADE,
            FOREIGN KEY (CreatorID)
              REFERENCES User(UserID)
              ON DELETE SET NULL 
              ON UPDATE CASCADE
          )",
          "CREATE TABLE Event (
            ID int NOT NULL,
            Time datetime NOT NULL,
            LocationID int NOT NULL,
            PRIMARY KEY (ID),
            FOREIGN KEY (LocationID)
              REFERENCES Location(ID)
              ON DELETE CASCADE 
              ON UPDATE CASCADE
          )",
          "CREATE TABLE Invited (
            EventID int NOT NULL,
            UserID varchar(7) NOT NULL,
            RSVP int NOT NULL,
            PRIMARY KEY (EventID, UserID),
            FOREIGN KEY (EventID)
              REFERENCES Event(ID)
              ON DELETE CASCADE 
              ON UPDATE CASCADE,
            FOREIGN KEY (UserID)
              REFERENCES User(UserID)
              ON DELETE CASCADE
              ON UPDATE CASCADE
          )",
          "CREATE TABLE Rating (
            UserID varchar(7) NOT NULL,
            LocationID int NOT NULL,
            Rating int NOT NULL,
            PRIMARY KEY (UserID, LocationID),
            FOREIGN KEY (UserID)
              REFERENCES User(UserID)
              ON DELETE CASCADE
              ON UPDATE CASCADE,
            FOREIGN KEY (LocationID)
              REFERENCES Location(ID)
              ON DELETE CASCADE
              ON UPDATE CASCADE
          )",
          "CREATE TABLE CheckIn (
            UserID varchar(7) NOT NULL,
            LocationID int NOT NULL,
            Time datetime NOT NULL,
            PRIMARY KEY (UserID, LocationID, Time),
            FOREIGN KEY (UserID)
              REFERENCES User(UserID)
              ON DELETE CASCADE
              ON UPDATE CASCADE,
            FOREIGN KEY (LocationID)
              REFERENCES Location(ID)
              ON DELETE CASCADE
              ON UPDATE CASCADE
          )"]
    
    sql.each do |table|
      ActiveRecord::Base.connection.execute(table)
    end
  end

  def down
  end
end
