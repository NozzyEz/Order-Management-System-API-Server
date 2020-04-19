class Mutations::CreateOrder < Mutations::BaseMutation
    argument :organization_id,  Integer,    required: true
    argument :user_id,          Integer,    required: true
    argument :paid,             Integer,    required: false
    argument :payment_type,     String,     required: true
    argument :status,           String,     required: false
    argument :product_ids,      [ID],       required: true


    field :order,       Types::OrderType,      null: false
    field :errors,      [String],              null: true

    def resolve(**attributes)
        authorize_user
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
