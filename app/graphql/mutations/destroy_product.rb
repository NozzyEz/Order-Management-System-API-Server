class Mutations::DestroyProduct < Mutations::BaseMutation
    argument :id, Integer, required: true

    type Types::ProductType

    def resolve(id:)
        authenticate_user
        if current_user.role == "admin"
            Product.find(id).destroy
        elsif current_user.role == "superuser" && current_user.organization.product_ids.include?(id)
            Product.find(id).destroy
        else
            raise GraphQL::ExecutionError, "Permission Denied"
        end
    end
end
