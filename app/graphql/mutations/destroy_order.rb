class Mutations::DestroyOrder < Mutations::BaseMutation
    argument :id, Integer, required: true

    type Types::OrderType

    def resolve(id:)
        authenticate_user
        if current_user.role == "admin"
            Order.find(id).destroy
        elsif current_user.role == "superuser" && current_user.organization.order_ids.include?(id)
            Order.find(id).destroy
        else
            raise GraphQL::ExecutionError, "Permission Denied"
        end
    end
end
