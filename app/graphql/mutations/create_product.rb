class Mutations::CreateProduct < Mutations::BaseMutation
    argument :name,                 String,     required: true
    argument :organization_id,      Integer,    required: true
    argument :description,          String,     required: true
    argument :inventory,            Integer,    required: false
    argument :images,               String,     required: false
    argument :price,                Float,      required: true

    field :product,    Types::ProductType,      null: false
    field :errors,     [String],                null: true

    def resolve(**attributes)
        authorize_user
        product = Product.new(attributes)

        if product.save
            {
                product: product,
                errors: []
            }
        else
            {
                product: nil,
                errors: product.errors.full_messages
            }
        end
    end
end