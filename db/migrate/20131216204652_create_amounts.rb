class CreateAmounts < ActiveRecord::Migration
  def change
    create_table :amounts do |t|
      t.string :type
      t.decimal :amount
      t.references :account
      t.references :transaction
      t.timestamps
    end
  end
end
