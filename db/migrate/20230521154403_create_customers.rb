class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :phone
      t.string :cpf
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
