class Discount < ApplicationRecord
  belongs_to :product

  scope :date_current, ->{where date: Time.zone.today.to_s}
end
