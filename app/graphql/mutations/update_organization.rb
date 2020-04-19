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
        authorize_user
        organization = Organization.find(attributes[:id])
        
        if organization.update(attributes)
            {organization: organization, errors: []}
        else
            {organization: nil, errors: organization.errors.full_messages}
        end
    end
end
