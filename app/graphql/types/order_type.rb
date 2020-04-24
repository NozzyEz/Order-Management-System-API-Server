module Types
    class OrderType < Types::BaseObject
        field :id,               ID,                              null: false
        field :organization_id,  Integer,                         null: true
        field :organization,     Types::OrganizationType,         null: true
        field :user_id,          Integer,                         null: true
        field :user,             Types::UserType,                 null: true
        field :paid,             Boolean,                         null: true
        field :payment_type,     String,                          null: true
        field :status,           String,                          null: true
        field :products,         [Types::ProductType],            null: true
        field :created_at,       GraphQL::Types::ISO8601DateTime, null: false 
        field :updated_at,       GraphQL::Types::ISO8601DateTime, null: false 

        def organization_id
            if current_user.admin? || current_user.superuser? || current_user.organization_id == object.organization_id
                object.organization_id
            end
        end
            
        def organization
            if current_user.admin? || current_user.superuser? || current_user.organization_id == object.organization_id
                    object.organization
            end
        end

        def user_id
            if current_user.admin? || current_user.superuser? || current_user.user_id == object.user_id
                object.user_id
            end
        end
            
        def user
            if current_user.admin? || current_user.superuser? || current_user.user_id == object.user_id
                    object.user_id
            end
        end
    end
end