class Mutations::UpdateUser < Mutations::BaseMutation
    argument :id,               Integer,    required: true
    argument :username,         String,     required: false
    argument :email,            String,     required: false
    argument :first_name,       String,     required: false
    argument :last_name,        String,     required: false
    argument :organization_id,  Integer,    required: false
    argument :role              String,     required: false

    field :user,    Types::UserType,    null: true
    field :errors,  [String],           null: true

    def resolve(**attributes)
        authenticate_user
        raise GraphQL::ExecutionError, "Permission Denied" unless current_user.admin? || current_user.superuser? || current_user.id == attributes[:id]
        
        if !current_user.admin? && attributes[:organization_id] != nil
            raise GraphQL::ExecutionError, "Not allowed to change organization unless admin"
        end

        user = User.find(attributes[:id])

        if current_user.superuser? && user.organization_id != current_user.organization_id
            raise GraphQL::ExecutionError, "Not allowed to update users outside of own organization"
        end

        if !current_user.admin?
            attributes[:role] = user.role
        end
        
        if user.update(attributes)
            # TODO Check if user needs to be fetched from context
            {user: user, errors: []}
        else
            {user: nil, errors: user.errors.full_messages}
        end
    end
end
