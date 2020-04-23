class Mutations::CreateProduct < Mutations::BaseMutation
    argument :name,                 String,     required: true
    argument :organization_id,      Integer,    required: false
    argument :description,          String,     required: true
    argument :inventory,            Integer,    required: false
    argument :images,               String,     required: false
    argument :price,                Float,      required: true

    field :product,    Types::ProductType,      null: false
    field :errors,     [String],                null: true

    def resolve(**attributes)
        authenticate_user
        # If user is admin and provides an organization id, allow creation of product
        if current_user.role == "admin"
            if attributes.has_key?(:organization_id)
                product = Product.new(attributes)
            else
                raise GraphQL::ExecutionError, "Organization_id needed"
            end
        # Otherwise if user is superuser, allow the ptoduct to be created in their organization
        elsif current_user.role == "superuser"
            attributes[:organization_id] = current_user.organization_id
            product = Product.new(attributes)
        else
            raise GraphQL::ExecutionError, "Permission Denied"
        end


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