class Organization < ApplicationRecord
    has_many :users
    has_many :products
    has_many :orders
    has_many :images, through: :products

    validates :verification_codem uniqueness: true
end
