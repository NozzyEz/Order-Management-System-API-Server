class Mutations::CreateOrder < Mutations::BaseMutation
    argument :id,               ID,                      required: true
    argument :organization_id,  Integer,                 required: true
    argument :user_id,          Integer,                 required: true
    argument :paid,             Integer,                 required: false
    argument :cost,             Integer,                 required: true
    argument :payment_type,     String,                  required: true
    argument :status,           String,                  required: false
    # argument :products,         [Types::ProductType],    required: true

    field :order,       Types::OrderType,      null: false
    field :errors,      [String],              null: true

    def resolve(**attributes)
        order = Order.new(attributes)

        if order.save
            {
                order: order,
                errors: []
            }
        else
            {
                order: nil,
                errors: order.errors.full_messages
            }
        end
    end
end