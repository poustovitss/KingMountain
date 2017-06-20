class AddInvitedByToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :invited_by, :integer
  end
end
