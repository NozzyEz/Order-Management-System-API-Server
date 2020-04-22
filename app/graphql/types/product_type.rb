module Types
    class ProductType < Types::BaseObject
        field :id,              ID,                              null: false
        field :name,            String,                          null: false
        field :organization_id, Integer,                         null: true
        field :organization,    Types::OrganizationType,         null: false
        field :description,     String,                          null: true
        field :inventory,       Integer,                         null: true
        field :price,           Float,                           null: false
        field :images,          [Types::ImageType],              null: true
        field :created_at,      GraphQL::Types::ISO8601DateTime, null: false
        field :updated_at,      GraphQL::Types::ISO8601DateTime, null: false  
    end
end