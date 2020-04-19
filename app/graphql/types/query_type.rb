module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    
    # Fields to retrieve lists of users and posts
    field :users,         [Types::UserType],          null: false
    field :organizations, [Types::OrganizationType],  null: false
    field :products,      [Types::ProductType],       null: false
    field :orders,        [Types::OrderType],         null: false
    
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    field :organization, Types::OrganizationType, null: false do
      argument :id, ID, required: true
    end

    field :product, Types::ProductType, null: false do
      argument :id, ID, required: true
    end
    
    field :order, Types::OrderType, null: false do
      argument :id, ID, required: true
    end

    # Methods to fetch lists of each type
    def users
      authorize_user
      User.all
    end

    def organizations
      authorize_user
      Organization.all
    end

    def products
      authorize_user
      Product.all
    end

    def orders
      authorize_user
      Order.all
    end

    # fetch a specific items of a type by their id
    def user(id:)
      authorize_user
      User.find(id)
    end

    def organization(id:)
      authorize_user
      Organization.find(id)
    end

    def product(id:)
      authorize_user
      Product.find(id)
    end
    
    def order(id:)
      authorize_user
      Order.find(id)
    end

    # Function to check is a user is signed in, we can call it within our other query functions 
    # that are used by our queries 
    def authorize_user
      return true if context[:current_user].present?

      raise GraphQL::ExecutionError, "User not signed in"
    end
  end
end
