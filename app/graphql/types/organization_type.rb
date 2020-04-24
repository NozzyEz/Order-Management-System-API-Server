module Types
    class OrganizationType < Types::BaseObject
        field :id,                  ID,                     null: false
        field :name,                String,                 null: true
        field :verification_code,   String,                 null: true
        field :users,               [Types::UserType],      null: true
        field :products,            [Types::ProductType],   null: true
        field :orders,              [Types::OrderType],     null: true
        field :created_at,       GraphQL::Types::ISO8601DateTime, null: false
        field :updated_at,       GraphQL::Types::ISO8601DateTime, null: false

        def verification_code
            if current_user.admin? || current_user.superuser? || current_user.organization_id == object.id
                object.verification_code
            end
        end
        
        def users
            # binding.pry
            if current_user.admin? || current_user.superuser?
                object.users
            else
                raise GraphQL::ExecutionError, "users query not allowed"
            end
        end
        
        def orders
            if current_user.admin? || current_user.superuser?
                object.orders
            else
               object.orders.where(user_id: current_user.id)
            end
        end

    end
end