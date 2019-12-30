class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :name, null: false
      t.string :status
      t.datetime :status_time

      t.timestamps
    end
    add_index :devices, :name, unique: true
  end
end
