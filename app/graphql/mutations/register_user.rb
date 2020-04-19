module Mutations
    class RegisterUser < BaseMutation
        # Specifying the arguments we take
        argument :registration_details, Types::UserInputType, required: true

        # Specifying the fields to save to
        field :user, Types::UserType, null: false
        field :errors, [String], null: true

        # The resolve method runs when the CreateUser mutation is queried, takes the arguments
        # and will then store these in the fields by invoking the new() method from the user model
        def resolve(**attributes)
            input = Hash[attributes[:registration_details].to_h.map{|k, v| [k.to_s.underscore.to_sym, v]}]
            
            user = User.create!(input)
            if user.save
                {user: user, errors: []}
            else
                {user: nil, errors: user.errors.full_messages}
            end
        end
    end
end
