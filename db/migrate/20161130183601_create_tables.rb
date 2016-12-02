class CreateTables < ActiveRecord::Migration[5.0]
  def up
    sql =["CREATE TABLE users (
            UserID varchar(7) NOT NULL,
            Nickname varchar(30),
            GradYear int,
            Major varchar(30),
            PRIMARY KEY (UserID)
          )",
          "CREATE TABLE friend_requests (
            FromUserID varchar(7) NOT NULL,
            ToUserID varchar(7) NOT NULL,
            AcceptanceStatus int NOT NULL,
            PRIMARY KEY (FromUserID, ToUserID),
            FOREIGN KEY (FromUserID)
              REFERENCES users(UserID)
              ON DELETE CASCADE
              ON UPDATE CASCADE,
            FOREIGN KEY (ToUserID)
              REFERENCES users(UserID)
              ON DELETE CASCADE
              ON UPDATE CASCADE
          )",
          "CREATE TABLE indoor_locations (
            IndoorID varchar(7) NOT NULL AUTO_INCREMENT,
            Building varchar(50) NOT NULL,
            Floor varchar(50),
            Room varchar(50),
            PRIMARY KEY (IndoorID)
          )",
          "CREATE TABLE locations (
            ID int NOT NULL AUTO_INCREMENT,
            Description varchar(100) NOT NULL,
            Latitude float NOT NULL,
            Longitude float NOT NULL,
            IndoorID varchar(7),
            CreatorID varchar(7),
            CreateTime datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (ID),
            FOREIGN KEY (IndoorID)
              REFERENCES indoor_locations(IndoorID)
              ON DELETE CASCADE
              ON UPDATE CASCADE,
            FOREIGN KEY (CreatorID)
              REFERENCES users(UserID)
              ON DELETE SET NULL
              ON UPDATE CASCADE
          )",
          "CREATE TABLE events (
            ID int NOT NULL AUTO_INCREMENT,
            Time datetime NOT NULL,
            LocationID int NOT NULL,
            PRIMARY KEY (ID),
            FOREIGN KEY (LocationID)
              REFERENCES locations(ID)
              ON DELETE CASCADE
              ON UPDATE CASCADE
          )",
          "CREATE TABLE invites (
            EventID int NOT NULL,
            UserID varchar(7) NOT NULL,
            RSVP int NOT NULL,
            PRIMARY KEY (EventID, UserID),
            FOREIGN KEY (EventID)
              REFERENCES events(ID)
              ON DELETE CASCADE
              ON UPDATE CASCADE,
            FOREIGN KEY (UserID)
              REFERENCES users(UserID)
              ON DELETE CASCADE
              ON UPDATE CASCADE
          )",
          "CREATE TABLE ratings (
            UserID varchar(7) NOT NULL,
            LocationID int NOT NULL,
            Rating int NOT NULL,
            PRIMARY KEY (UserID, LocationID),
            FOREIGN KEY (UserID)
              REFERENCES users(UserID)
              ON DELETE CASCADE
              ON UPDATE CASCADE,
            FOREIGN KEY (LocationID)
              REFERENCES locations(ID)
              ON DELETE CASCADE
              ON UPDATE CASCADE
          )",
          "CREATE TABLE check_ins (
            UserID varchar(7) NOT NULL,
            LocationID int NOT NULL,
            Time datetime NOT NULL,
            PRIMARY KEY (UserID, LocationID, Time),
            FOREIGN KEY (UserID)
              REFERENCES users(UserID)
              ON DELETE CASCADE
              ON UPDATE CASCADE,
            FOREIGN KEY (LocationID)
              REFERENCES locations(ID)
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
