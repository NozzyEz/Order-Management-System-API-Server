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
      argument :id, Integer, required: true
    end

    field :organization, Types::OrganizationType, null: false do
      argument :id, Integer, required: true
    end

    field :product, Types::ProductType, null: false do
      argument :id, Integer, required: true
    end
    
    field :order, Types::OrderType, null: false do
      argument :id, Integer, required: true
    end

    field :filter_orders, resolver: Resolvers::OrdersSearch

    field :image, Types::ImageType, null: false do
      argument :id, Integer, required: true
    end

    # Methods to fetch lists of each type
    def users
      # binding.pry
      authenticate_user

      # If current user is designated a super user, return all users in their organization, 
      # otherwise if admin, return all - if neither is true, deny query
      if current_user.superuser?
        # show all users in same organization
        User.where(organization_id: current_user.organization_id)
      elsif current_user.admin?
        User.all
      else
        raise GraphQL::ExecutionError, "Permission denied"
      end
    end

    def organizations
      authenticate_user
      # Allow admin to see all organizations, otherwise only show organizations affiliated with user
      if current_user.admin?
        Organization.all
      else
        Organization.where(organization_id: current_user.organization_id)
      end

    end

    def products
      authenticate_user
      binding.pry
      # Allow admin to see all products, otherwise only show products affiliated with organization
      if current_user.admin?
        Product.all
      else
        Product.where(organization_id: current_user.organization_id)
      end
    end

    def orders
      authenticate_user
      # Allow admin to see all orders. superuser can see orders in their organization, and user can 
      # see their own orders only.
      if current_user.admin?
        Order.all
      elsif current_user.superuser?
        Order.where(organization_id: current_user.organization_id)
      else
        Order.where(user_id: current_user.id)
      end

    end

    def images
      # binding.pry
      authenticate_user
      if current_user.admin?
        Image.all
      else
        raise GraphQL::ExecutionError, "Permission Denied"
      end
    end
    
    # fetch a specific user by their id if admin, if superuser check to see if queried user is in 
    # the same organization, if that's the case, allow the query
    def user(id:)
      authenticate_user
      if current_user.admin?
        User.find(id)
      elsif current_user.superuser?
        # Raise an error unless we can find a user with the id within our current user's organization's users
        raise GraphQL::ExecutionError, "Permission Denied" unless user = current_user.organization.users.find_by(id: id)
      else
        raise GraphQL::ExecutionError, "Permission Denied"
      end
    end

    def organization(id:)
      authenticate_user
      if current_user.admin?
        Organization.find(id)
      else
        # binding.pry
        raise GraphQL::ExecutionError, "Permission Denied" unless current_user.organization_id == id
        current_user.organization
      end
    end

    def product(id:)
      authenticate_user
      if current_user.admin?
        Product.find(id)
      else
        raise GraphQL::ExecutionError, "Permission Denied" unless product = current_user.organization.products.find_by(id: id)
      end
    end
    
    def order(id:)
      authenticate_user
      if current_user.admin?
        Order.find(id)
      elsif current_user.superuser?
        raise GraphQL::ExecutionError, "Permission Denied" unless order = current_user.organization.orders.find_by(id: id)
      else
        raise GraphQL::ExecutionError, "Permission Denied" unless order = current_user.orders.find_by(id: id)
      end
    end
    
    def image(id:)
      authenticate_user
      Image.find(id)
    end

    # Function to check is a user is signed in, we can call it within our other query functions 
    # that are used by our queries 
    def authenticate_user
      return true if current_user.present?

      raise GraphQL::ExecutionError, "User not signed in"
    end
  end
end
