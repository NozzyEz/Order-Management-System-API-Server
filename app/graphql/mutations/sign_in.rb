module Mutations
    class SignIn < BaseMutation
        argument :email, String, required: true
        argument :password, String, required: true

        type Types::AuthType

        def resolve(**attributes)
            user = User.find_for_database_authentication(email: attributes[:email])

            if user
                if user.valid_password?(attributes[:password])
                    # When user signs in, we want to save them to refresh their token and update 
                    # when it was created at
                    user.save

                    authentication_token = user.authentication_token
                    return { authentication_token: authentication_token, user: user }
                else
                    raise GraphQL::ExecutionError, 'Incorrect Email/Password'
                end
            else
                raise GraphQL::ExecutionError, 'User not registered'
            end

        end
    end
end