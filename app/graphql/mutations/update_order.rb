class Mutations::UpdateOrder < Mutations::BaseMutation
    # Arguments
    argument :id,               ID,                      required: true
    argument :organization_id,  Integer,                 required: false
    argument :user_id,          Integer,                 required: false
    argument :paid,             Integer,                 required: false
    argument :cost,             Integer,                 required: false
    argument :payment_type,     String,                  required: false
    argument :status,           String,                  required: false
    # argument :products,         [Types::ProductType],    required: false


    # Fields
    field :order,           Types::OrderType,     null: true
    field :errors,          [String],             null: true

    # resolve method
    def resolve(**attributes)
        order = Order.find(attributes[:id])
        
        if order.update(attributes)
            {order: order, errors: []}
        else
            {order: nil, errors: order.errors.full_messages}
        end
    end
end
