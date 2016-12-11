class AddCreatorIdToEvents < ActiveRecord::Migration[5.0]
  def change
    Event.connection.execute("ALTER TABLE events ADD creator_id varchar(7), ADD FOREIGN KEY (creator_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE")
  end
end
