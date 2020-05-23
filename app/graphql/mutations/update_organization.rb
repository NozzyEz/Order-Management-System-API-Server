class Mutations::UpdateOrganization < Mutations::BaseMutation
    # Arguments
    argument :id,                   Integer,    required: true
    argument :name,                 String,     required: false
    argument :verification_code,    String,     required: false
    

    # Fields
    field :organization,    Types::OrganizationType,     null: true
    field :errors,          [String],                    null: true

    # resolve method
    def resolve(**attributes)
        authenticate_user

        raise GraphQL::ExecutionError, "Permission denied" unless current_user.admin? || current_user.superuser?
        organization = Organization.find(attributes[:id])

        if current_user.superuser? && current_user.organization_id != organization.id
            raise GraphQL::ExecutionError, "Can only change own organization"
        end

        if organization.update(attributes)
            {organization: organization, errors: []}
        else
            raise GraphQL::ExecutionError, organization.errors.full_messages.join(", ")
        end
    end
end
