class NewColTrxnsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :spend_category_id_user, :integer
  end
end
