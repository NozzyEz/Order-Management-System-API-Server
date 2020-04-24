module Mutations
    class RegisterUser < BaseMutation
        # Specifying the arguments we take
        argument :registration_details, Types::UserInputType, required: true
        argument :verification_code,    String,               required: true

        # Specifying the fields to save to
        field :user, Types::UserType, null: true
        field :errors, [String], null: true

        # The resolve method runs when the CreateUser mutation is queried, takes the arguments
        # and will then store these in the fields by invoking the new() method from the user model
        def resolve(**attributes)
            input = Hash[attributes[:registration_details].to_h.map{|k, v| [k.to_s.underscore.to_sym, v]}]
            # binding.pry
            input[:organization_id] = Organization.find_by(verification_code: attributes[:verification_code])&.id
            
            user = User.create(input)
            
            if user.persisted?
                {user: user, errors: []}
            else
                {user: nil, errors: user.errors.full_messages}
            end
        end
    end
end
