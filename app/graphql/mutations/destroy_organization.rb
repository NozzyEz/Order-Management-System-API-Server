class Mutations::DestroyOrganization < Mutations::BaseMutation
    argument :id, Integer, required: true

    type Types::OrganizationType

    def resolve(id:)
        authenticate_user
        if current_user.role == "admin"
            Organization.find(id).destroy
        else
            raise GraphQL::ExecutionError, "Permission Denied"
        end
    end
end
