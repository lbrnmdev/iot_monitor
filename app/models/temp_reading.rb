class TempReading < ApplicationRecord
  belongs_to :device
  validates :received_time, presence: true
end
