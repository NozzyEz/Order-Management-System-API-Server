module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    
    # Fields to retrieve lists of users and posts
    field :users, [Types::UserType], null: false
    field :posts, [Types::PostType], null: false
    
    # field to return specific user with the provided user id
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end
    
    field :post, Types::PostType, null: false do
      argument :id, Integer, required: true
    end

    # TODO make queries for finding users and posts by other fields than their id

    #! Method to fetch all users
    def users
      User.all
    end
    def posts
      Post.all
    end

    # fetch a user with a user id
    def user(id:)
      User.find(id)
    end

    def post(id:)
      Post.find(id)
    end
  end
end
