require 'uri'
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
            input[:organization_id] = nil
            raise GraphQL::ExecutionError, "Please use a valid verification code" unless 
                org_id = Organization.find_by(verification_code: attributes[:verification_code])&.id
            input[:organization_id] = org_id

            raise GraphQL::ExecutionError, "Please make sure the passwords match" unless input[:password] == input[:password_confirmation]
            
            # TODO Fix email verification
            # raise GraphQL::ExecutionError, "The passwords doesn't match" unless input[:email] =~ URI::MailTo::EMAIL_REGEXP


            user = User.create(input)
            
            if user.persisted?
                context[:current_user] = user
                {user: user, errors: []}
            else
                {user: nil, errors: user.errors.full_messages}
            end
        end
    end
end
