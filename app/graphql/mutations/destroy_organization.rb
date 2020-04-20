class Mutations::DestroyOrganization < Mutations::BaseMutation
    argument :id, Integer, required: true

    type Types::OrganizationType

    def resolve(id:)
        authenticate_user
        Organization.find(id).destroy
    end
end
