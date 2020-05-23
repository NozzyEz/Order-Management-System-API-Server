class Mutations::UpdateOrder < Mutations::BaseMutation
    # Arguments
    argument :id,               Integer,                 required: true
    argument :organization_id,  Integer,                 required: false
    argument :user_id,          Integer,                 required: false
    argument :paid,             Integer,                 required: false
    argument :cost,             Integer,                 required: false
    argument :payment_type,     String,                  required: false
    argument :status,           String,                  required: false
    argument :product_ids,      [ID],                    required: false

    # Fields
    field :order,           Types::OrderType,     null: true
    field :errors,          [String],             null: true

    # resolve method
    def resolve(**attributes)
        authenticate_user
        
        # throw regular user out
        raise GraphQL::ExecutionError, "Permission Denied" unless current_user.admin? || current_user.superuser?
      
        # don't let superuser touch order's organization
        attributes.delete(:organization_id) unless current_user.admin?
      
        # find order just once
        order = Order.find(attributes[:id])
      
        # throw superuser out if they're trying to edit order that doesn't belong to their organization
        if current_user.superuser? && order.organization_id != current_user.organization_id
          raise GraphQL::ExecutionError, "Permission Denied"
        end
      
        if order.update(attributes)
            {order: order, errors: []}
        else
            raise GraphQL::ExecutionError, order.errors.full_messages.join(", ")
        end
    end
end