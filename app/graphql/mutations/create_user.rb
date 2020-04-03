class Mutations::CreateUser < Mutations::BaseMutation
    # Specifying the arguments we take
    argument :name, String, required: true
    argument :email, String, required: true

    # Specifying the fields to save to
    field :user, Types::UserType, null: false
    field :errors, [String], null: true

    # The resolve method runs when the CreateUser mutation is queried, and takes the arguments
    # and will then store these in the fields by invoking the new() method from the user model
    def resolve(name:, email:)
        user = User.new(name: name, email: email)
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