class AddUserToGetbalances < ActiveRecord::Migration[5.0]
  def change
    add_reference :getbalances, :user, foreign_key: true
  end
end
