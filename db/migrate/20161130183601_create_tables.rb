class CreateTables < ActiveRecord::Migration[5.0]
  def up
    sql =["CREATE TABLE users (
            user_id varchar(7) NOT NULL,
            nickname varchar(30),
            grad_year int,
            major varchar(30),
            PRIMARY KEY (user_id)
          )",
          "CREATE TABLE friend_requests (
            from_user_id varchar(7) NOT NULL,
            to_user_id varchar(7) NOT NULL,
            acceptance_status int NOT NULL,
            PRIMARY KEY (from_user_id, to_user_id),
            FOREIGN KEY (from_user_id)
              REFERENCES users(user_id)
              ON DELETE CASCADE
              ON UPDATE CASCADE,
            FOREIGN KEY (to_user_id)
              REFERENCES users(user_id)
              ON DELETE CASCADE
              ON UPDATE CASCADE
          )",
          "CREATE TABLE indoor_locations (
            id int NOT NULL AUTO_INCREMENT,
            building varchar(50) NOT NULL,
            floor varchar(50),
            room varchar(50),
            PRIMARY KEY (id)
          )",
          "CREATE TABLE locations (
            id int NOT NULL AUTO_INCREMENT,
            description varchar(100) NOT NULL,
            latitude float NOT NULL,
            longitude float NOT NULL,
            indoor_location_id int,
            CreatorID varchar(7),
            CreateTime datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (ID),
            FOREIGN KEY (indoor_location_id)
              REFERENCES indoor_locations(id)
              ON DELETE CASCADE
              ON UPDATE CASCADE,
            FOREIGN KEY (CreatorID)
              REFERENCES users(user_id)
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
            user_id varchar(7) NOT NULL,
            RSVP int NOT NULL,
            PRIMARY KEY (EventID, user_id),
            FOREIGN KEY (EventID)
              REFERENCES events(ID)
              ON DELETE CASCADE
              ON UPDATE CASCADE,
            FOREIGN KEY (user_id)
              REFERENCES users(user_id)
              ON DELETE CASCADE
              ON UPDATE CASCADE
          )",
          "CREATE TABLE ratings (
            user_id varchar(7) NOT NULL,
            LocationID int NOT NULL,
            Rating int NOT NULL,
            PRIMARY KEY (user_id, LocationID),
            FOREIGN KEY (user_id)
              REFERENCES users(user_id)
              ON DELETE CASCADE
              ON UPDATE CASCADE,
            FOREIGN KEY (LocationID)
              REFERENCES locations(ID)
              ON DELETE CASCADE
              ON UPDATE CASCADE
          )",
          "CREATE TABLE check_ins (
            user_id varchar(7) NOT NULL,
            LocationID int NOT NULL,
            Time datetime NOT NULL,
            PRIMARY KEY (user_id, LocationID, Time),
            FOREIGN KEY (user_id)
              REFERENCES users(user_id)
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
