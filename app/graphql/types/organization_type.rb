module Types
    class OrganizationType < Types::BaseObject
        field :id,                  ID,                     null: false
        field :name,                String,                 null: true
        field :verification_code,   String,                 null: true
        field :users,               [Types::UserType],      null: true
        field :products,            [Types::ProductType],   null: true
        field :orders,              [Types::OrderType],     null: true
        field :created_at,       GraphQL::Types::ISO8601DateTime, null: false
        field :updated_at,       GraphQL::Types::ISO8601DateTime, null: false 
    end
end