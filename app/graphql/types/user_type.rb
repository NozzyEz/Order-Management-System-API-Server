module Types
  class UserType < Types::BaseObject
    field :id,                ID,                 null: false
    field :username,          String,             null: true
    field :organization_id,   Integer,            null: true
    field :first_name,        String,             null: true
    field :last_name,         String,             null: true
    field :email,             String,             null: true

  end
end
