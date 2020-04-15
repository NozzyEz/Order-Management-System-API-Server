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
    
    field :orders, Types::OrderType, null: false do
      argument :id, ID, required: true
    end

    # Methods to fetch lists of each type
    def users
      User.all
    end

    def organizations
      Organization.all
    end

    def products
      Product.all
    end

    def orders
      Order.all
    end

    # fetch a specific items of a type by their id
    def user(id:)
      User.find(id)
    end

    def organization(id:)
      Organization.find(id)
    end

    def product(id:)
      Product.find(id)
    end
    
    def order(id:)
      Order.find(id)
    end
  end
end
