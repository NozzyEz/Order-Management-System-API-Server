module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    
    # Fields to retrieve lists of users and posts
    field :users,         [Types::UserType],          null: false
    field :organizations, [Types::OrganizationType],  null: false
    field :products,      [Types::ProductType],       null: false
    field :orders,        [Types::OrderType],         null: false
    field :images,        [Types::ImageType],         null: false
    
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

    field :image, Types::ImageType, null: false do
      argument :id, ID, required: true
    end

    # Methods to fetch lists of each type
    def users
      # binding.pry
      authenticate_user

      # If current user is designated a super user, return all users in their organization, 
      # otherwise if admin, return all - if neither is true, deny query
      if current_user.role != "user"
        if current_user.role == "superuser"
          # show all users in same organization
          User.where(organization_id: current_user.organization_id)
        elsif current_user.role == "admin"
          User.all
        end
      else
        raise GraphQL::ExecutionError, "Permission denied"
      end
    end

    def organizations
      authenticate_user
      # Allow admin to see all organizations, otherwise only show organizations affiliated with user
      if current_user.role == "admin"
        Organization.all
      else
        Organization.where(organization_id: current_user.organization_id)
      end

    end

    def products
      authenticate_user
      # Allow admin to see all products, otherwise only show products affiliated with organization
      if current_user.role == "admin"
        Product.all
      else
        Product.where(organization_id: current_user.organization_id)
      end
    end

    def orders
      authenticate_user
      # Allow admin to see all orders. superuser can see orders in their organization, and user can 
      # see their own orders only.
      if current_user.role == "admin"
        Order.all
      elsif current_user.role == "superuser"
        Order.where(organization_id: current_user.organization_id)
      else
        Order.where(user_id: current_user.id)
      end

    end

    def images
      # binding.pry
      authenticate_user
      if current_user.role == "admin"
        Image.all
      else
        raise GraphQL::ExecutionError, "Permission Denied"
      end
    end

    # fetch a specific items of a type by their id
    def user(id:)
      authenticate_user
      User.find(id)
    end

    def organization(id:)
      authenticate_user
      Organization.find(id)
    end

    def product(id:)
      authenticate_user
      Product.find(id)
    end
    
    def order(id:)
      authenticate_user
      Order.find(id)
    end
    
    def image(id:)
      authenticate_user
      Image.find(id)
    end

    # Function to check is a user is signed in, we can call it within our other query functions 
    # that are used by our queries 
    def authenticate_user
      return true if context[:current_user].present?

      raise GraphQL::ExecutionError, "User not signed in"
    end
  end
end
