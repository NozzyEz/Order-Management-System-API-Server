module Types
    class ProductType < Types::BaseObject
        field :id,              ID,                         null: false
        field :name,            String,                     null: true
        field :organization_id, Integer,                    null: true
        field :organization,    Types::OrganizationType,    null: true
        field :description,     String,                     null: true
        field :inventory,       Integer,                    null: true
        field :price,           Float,                      null: true
        field :images,          String,                     null: true
    end
end