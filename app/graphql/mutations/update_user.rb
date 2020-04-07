class Mutations::UpdateUser < Mutations::BaseMutation
    # Arguments
    argument :id,                       Integer,    required: true
    argument :username,                 String,     required: true
    argument :email,                    String,     required: true
    argument :first_name,               String,     required: true
    argument :last_name,                String,     required: true

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
