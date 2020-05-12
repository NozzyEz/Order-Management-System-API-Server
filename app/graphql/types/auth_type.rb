module Types
    class AuthType < BaseObject
        field :authentication_token, String, null: false
        field :user, Types::UserType, null: false
    end
end