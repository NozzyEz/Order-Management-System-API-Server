module Types
  class UserType < Types::BaseObject
    field :id,                    ID,                              null: false
    field :username,              String,                          null: true
    field :organization_id,       Integer,                         null: true
    field :organization,          Types::OrganizationType,         null: true
    field :order_ids,             [Integer],                       null: true
    field :orders,                [Types::OrderType],              null: true
    field :first_name,            String,                          null: true
    field :last_name,             String,                          null: true
    field :email,                 String,                          null: true
    field :authentication_token,  String,                          null: false
    field :created_at,            GraphQL::Types::ISO8601DateTime, null: false 
    field :updated_at,            GraphQL::Types::ISO8601DateTime, null: false

    # we're specifying a function for the auth_token to make sure that it is only the user of the 
    # curently signed in user's auth_token tha can be retrieved
    def authentication_token
      # binding.pry
      if object.id != context[:current_user]&.id
        raise GraphQL::UnauthorizedFieldError,
              "Unable to access authentication_token"
      end

      object.authentication_token
    end
  end
end
