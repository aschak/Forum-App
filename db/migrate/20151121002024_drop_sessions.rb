class DropSessions < ActiveRecord::Migration
  def change
    # TODO
    drop_table :sessions
  end
end
