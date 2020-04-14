class Mutations::UpdateUser < Mutations::BaseMutation
    # Arguments
    argument :id,                       Integer,    required: true
    argument :username,                 String,     required: false
    argument :email,                    String,     required: false
    argument :first_name,               String,     required: false
    argument :last_name,                String,     required: false
    argument :org_id,                   Integer,    required: false

    # Fields
    field :user,    Types::UserType,    null: true
    field :errors,  [String],           null: true

    # resolve method
    def resolve(**attributes)
        user = User.find(attributes[:id])
        
        if user.update(attributes)
            {user: user, errors: []}
        else
            {user: nil, errors: post.errors.full_messages}
        end
    end
end
