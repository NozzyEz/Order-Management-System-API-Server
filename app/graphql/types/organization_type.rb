module Types
    class OrganizationType < Types::BaseObject
        field :id,                  ID,                 null: false
        field :name,                String,             null: true
        field :verification_code,   String,             null: true
        field :users,               [Types::UserType],  null: true
    end
end