class Mutations::UpdateProduct < Mutations::BaseMutation
    argument :id,                   ID,         required: true
    argument :name,                 String,     required: false
    argument :organization_id,      Integer,    required: false
    argument :description,          String,     required: false
    argument :price,                Float,      required: false
    argument :inventory,            Integer,    required: false
    argument :images,               String,     required: false

    field :product,    Types::ProductType,      null: false
    field :errors,     [String],                null: true

    def resolve(**attributes)
        product = Product.find(attributes[:id])

        if product.update(attributes)
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