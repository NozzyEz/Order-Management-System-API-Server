module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    
    # Field to return all users
    field :users, [Types::UserType], null: false
    
    # field to return specific user with the provided user id
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    # Method to fetch all users
    def users
      User.all
    end

    # fetch a user with a user id
    def user(id:)
      User.find(id)
    end
  end
end
