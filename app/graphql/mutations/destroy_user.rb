class Mutations::DestroyUser < Mutations::BaseMutation
    argument :id, Integer, required: true

    type Types::UserType

    def resolve(id:)
        authenticate_user
        if current_user.role == "admin"
            User.find(id).delete
        elsif current_user.role == "superuser" && current_user.organization.user_ids.include?(id)
            User.find(id).delete
        else
            raise GraphQL::ExecutionError, "Permission Denied"
        end
    end
end
