module Types
    class OrderType < Types::BaseObject
        field :id,               ID,                              null: false
        field :organization_id,  Integer,                         null: true
        field :organization,     Types::OrganizationType,         null: true
        field :user_id,          Integer,                         null: true
        field :user,             Types::UserType,                 null: true
        field :paid,             Boolean,                         null: true
        field :payment_type,     String,                          null: true
        field :status,           String,                          null: true
        field :products,         [Types::ProductType],            null: true
        field :created_at,       GraphQL::Types::ISO8601DateTime, null: true 
        field :updated_at,       GraphQL::Types::ISO8601DateTime, null: true 
    end
end