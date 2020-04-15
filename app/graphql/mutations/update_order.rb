class Mutations::UpdateOrder < Mutations::BaseMutation
    # Arguments
    argument :id,               ID,                      null: true
    argument :organization_id,  Integer,                 null: false
    argument :user_id,          Integer,                 null: false
    argument :paid,             Integer,                 null: false
    argument :cost,             Integer,                 null: false
    argument :payment_type,     String,                  null: false
    argument :status,           String,                  null: false
    argument :products,         [Types::ProductType],    null: false


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
