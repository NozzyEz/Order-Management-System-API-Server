class Mutations::CreateUser < Mutations::BaseMutation
    # Specifying the arguments we take
    argument :username,                 String,     required: true
    argument :email,                    String,     required: true
    argument :first_name,               String,     required: true
    argument :last_name,                String,     required: true
    argument :password,                 String,     required: true
    argument :password_confirmation,    String,     required: true
    argument :organization_id,          Integer,    required: true

    # Specifying the fields to save to
    field :user, Types::UserType, null: false
    field :errors, [String], null: true

    # The resolve method runs when the CreateUser mutation is queried, takes the arguments
    # and will then store these in the fields by invoking the new() method from the user model
    def resolve(username:, email:, organization_id:, first_name:, last_name:, password:, password_confirmation:)
        user = User.new(
            username: username,
            email: email, 
            organization_id: organization_id,
            first_name: first_name, 
            last_name: last_name,
            password: password,
            password_confirmation: password_confirmation
        )
        # if the user is being saved, we will return the object along with an empty array of errors
        if user.save
            {
                user: user,
                errors: []
            }
        # else we will return a nil user and a full list of any errors 
        else
            {
                user: nil,
                errors: user.errors.full_messages
            }
        end
    end
end 