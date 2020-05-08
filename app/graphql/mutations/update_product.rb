class Mutations::UpdateProduct < Mutations::BaseMutation
    argument :id,                   ID,         required: true
    argument :name,                 String,     required: false
    argument :organization_id,      Integer,    required: false
    argument :description,          String,     required: false
    argument :price,                Float,      required: false
    argument :inventory,            Integer,    required: false
    argument :image_ids,            [ID],       required: false

    field :product,    Types::ProductType,      null: false
    field :errors,     [String],                null: true

    def resolve(**attributes)
        authenticate_user
        raise GraphQL::ExecutionError, "Permission Denied" unless current_user.admin? || current_user.superuser?
        product = Product.find(attributes[:id])

        if current_user.superuser? && product.organization_id != current_user.organization_id
            raise GraphQL::ExecutionError, "Can only update product in own organization"
        end

        if product.update(attributes)
            {product: product, errors: []}
        else
            {product: nil, errors: product.errors.full_messages}
        end
    end
end