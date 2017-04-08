class CreateIps < ActiveRecord::Migration[5.0]
  def change
    create_table :ips do |t|
      t.inet :address, null: false
      t.boolean :active, null: false, default: true

      t.timestamps
    end

    add_index :ips, :address, unique: true
  end
end
