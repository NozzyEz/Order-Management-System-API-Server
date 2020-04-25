class Mutations::UpdateUser < Mutations::BaseMutation
    # Arguments
    argument :id,               Integer,    required: true
    argument :username,         String,     required: false
    argument :email,            String,     required: false
    argument :first_name,       String,     required: false
    argument :last_name,        String,     required: false
    argument :organization_id,  Integer,    required: false

    # Fields
    field :user,    Types::UserType,    null: true
    field :errors,  [String],           null: true

    # resolve method
    def resolve(**attributes)
        authenticate_user
        raise GraphQL::ExecutionError, "Permission Denied" unless current_user.admin? || current_user.superuser? || current_user.id == attributes[:id]
        user = User.find(attributes[:id])

        if current_user.superuser? && user.organization_id != current_user.organization_id
            raise GraphQL::ExecutionError, "Not allowed to update users outside of own organization"
        end
        
        if user.update(attributes)
            {user: user, errors: []}
        else
            {user: nil, errors: user.errors.full_messages}
        end
    end
end
