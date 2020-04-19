module Mutations
    class SignIn < BaseMutation
        argument :email, String, required: true
        argument :password, String, required: true

        type Types::AuthType

        def resolve(**attributes)
            user = User.find_for_database_authentication(email: attributes[:email])

            if user
                if user.valid_password?(attributes[:password])
                    authentication_token = user.authentication_token
                    return OpenStruct.new(authentication_token: authentication_token)
                else
                    raise GraphQL::ExecutionError, 'Incorrect Email/Password'
                end
            else
                raise GraphQL::ExecutionError, 'User not registered'
            end
        end
    end
end