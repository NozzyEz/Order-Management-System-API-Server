module Mutations
    class SignIn < Mutations::BaseMutation
        argument :email, String, null: false
        argument :password, String, null: false

        type Types::AuthType

        def resolve(**attributes)
            user = User.find_for_database_authentication(email: attributes[:email])

            if user
                if user.valid_password?(attributes[:password])
                    authentication_token = user.authentication_token
                    return OpenStruct.new(authentication_token: authentication_token)
                else
                    GraphQL::ExecutionError, 'Incorrect Email/Password'
                end
            else
                GraphQL::ExecutionError, 'User not registered'
            end
        end
    end
end