class Mutations::CreateOrder < Mutations::BaseMutation
    argument :id,               ID,                      null: false
    argument :organization_id,  Integer,                 null: false
    argument :user_id,          Integer,                 null: false
    argument :paid,             Integer,                 null: false
    argument :cost,             Integer,                 null: false
    argument :payment_type,     String,                  null: false
    argument :status,           String,                  null: false
    argument :products,         [Types::ProductType],    null: false

    field :order,    Types::OrderType,      null: false
    field :errors,     [String],            null: true

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