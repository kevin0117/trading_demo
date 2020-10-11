class CreateCommodities < ActiveRecord::Migration[6.0]
  def change
    create_table :commodities do |t|
      t.string :title
      t.integer :quantity
      t.string :status
      t.decimal :price
      t.integer :action
      t.integer :closer_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
