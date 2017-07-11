class AddSkypeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :skype, :string
  end
end
