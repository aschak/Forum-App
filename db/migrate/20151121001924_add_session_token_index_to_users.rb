class AddSessionTokenIndexToUsers < ActiveRecord::Migration
  def change
    #TODO
    add_index :users, :session_token, unique: true
  end
end
