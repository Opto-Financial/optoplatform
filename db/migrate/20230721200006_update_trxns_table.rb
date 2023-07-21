class UpdateTrxnsTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :transactions, :spend_category_id, :spend_category_id_default
  end
end
