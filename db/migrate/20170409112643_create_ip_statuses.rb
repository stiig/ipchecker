class CreateIpStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :ip_statuses do |t|
      t.float :duration
      t.boolean :success, null: false, default: false
      t.references :ip, index: true, foreign_key: true, null: false
      t.timestamps
    end
  end
end
