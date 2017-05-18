class AddSummaToTransfers < ActiveRecord::Migration[5.0]
  def change
    add_column :transfers, :summa, :floating
  end
end
