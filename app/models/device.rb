class Device < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :temp_readings, -> { order "received_time DESC" }
end
