class Order < ApplicationRecord
  belongs_to :organization
  has_many :products
end
