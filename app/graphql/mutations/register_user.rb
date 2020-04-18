module Mutations
    class RegisterUser < BaseMutation
        argument :registration_details, Types::UserInputType, null: false

        type Types::UserType

        def resolve(**attributes)
            User.new(attributes)
            if user.save
                {user: user, errors: []}
            # else we will return a nil user and a full list of any errors 
            else
                {user: nil, errors: user.errors.full_messages}
            end
        end
    end
end