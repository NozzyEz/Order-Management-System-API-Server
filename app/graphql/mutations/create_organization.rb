class Mutations::CreateOrganization < Mutations::BaseMutation
    argument :name,                 String, required: true
    argument :verification_code,    String, required: true

    field :organization,    Types::OrganizationType,    null: false
    field :errors,          [String],                   null: true

    def resolve(name:, verification_code:)
        organization = Organization.new(
            name: name,
            verification_code: verification_code
        )

        if organization.save
            {
                organization: organization,
                errors: []
            }
        else
            {
                organization: nil,
                errors: organization.errors.full_messages
            }
        end
    end
end