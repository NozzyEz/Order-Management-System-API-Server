class Mutations::CreateOrder < Mutations::BaseMutation
    argument :organization_id,  Integer,    required: false
    argument :user_id,          Integer,    required: false
    argument :paid,             Boolean,    required: false
    argument :payment_type,     String,     required: true
    argument :status,           String,     required: false
    argument :product_ids,      [Integer],       required: true


    field :order,       Types::OrderType,      null: false
    field :errors,      [String],              null: true

    def resolve(**attributes)
        authenticate_user
        # binding.pry
        # check if current_user is admin, which can create order for any user in any organization
        if current_user.admin?
            if attributes.has_key?(:user_id) && attributes.has_key?(:organization_id)
                order = Order.new(attributes)
            else
                raise GraphQL::ExecutionError, "user_id and organization_id has to be provided"
            end
            
        # or if super user, only use current_user's organization_id as argument
        elsif current_user.superuser?
            attributes[:organization_id] = current_user.organization_id
            raise GraphQL::ExecutionError, "user_id has to be provided" unless attributes.has_key?(:user_id)
            order = Order.new(attributes)
        # or if user, only allow to use current_user.id and current_user.organization_id
        else
            attributes[:user_id] = current_user.id
            attributes[:organization_id] = current_user.organization_id
            order = Order.new(attributes)
        end
        if order.save
            {order: order,errors: []}
        else
            raise GraphQL::ExecutionError, order.errors.full_messages.join(", ")
        end
    end
end
