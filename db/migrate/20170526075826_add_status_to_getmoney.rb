class AddStatusToGetmoney < ActiveRecord::Migration[5.0]
  def change
    add_column :getmoneys, :status, :string
  end
end
