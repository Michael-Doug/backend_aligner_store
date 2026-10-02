class AddIntegrityConstraints < ActiveRecord::Migration[7.0]
  def change
    change_column_null :stores, :name, false
    change_column_null :sellers, :name, false
    change_column_null :payments, :name, false
    change_column_null :products, :name, false
    change_column_null :products, :price, false
    change_column_null :customers, :name, false
    change_column_null :customers, :cpf, false
    change_column_null :order_items, :quantity, false

    change_column_default :orders, :total_value, from: nil, to: 0

    add_index :payments, :name, unique: true
    add_index :customers, :cpf, unique: true
  end
end
