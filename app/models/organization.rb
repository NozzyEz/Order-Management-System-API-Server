class Organization < ApplicationRecord
    has_many :users
    has_many :products
    has_many :orders
end
