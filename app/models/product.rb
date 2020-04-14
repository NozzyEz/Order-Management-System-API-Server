class Product < ApplicationRecord
    belongs_to :organization
    has_many :orders
end
