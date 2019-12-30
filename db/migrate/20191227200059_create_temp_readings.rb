class CreateTempReadings < ActiveRecord::Migration[6.0]
  def change
    create_table :temp_readings do |t|
      t.decimal :value
      t.string :unit
      t.datetime :received_time, null:false
      t.references :device, null: false, foreign_key: true

      t.timestamps
    end
  end
end
