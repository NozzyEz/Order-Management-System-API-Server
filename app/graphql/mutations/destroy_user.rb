class Mutations::DestroyUser < Mutations::BaseMutation
    argument :id, Integer, required: true

    # field :post,    Types::PostType,    null: true
    # field :errors,  [String],           null: true

    type Types::UserType

    def resolve(id:)
        authorize_user
        User.find(id).destroy
    end
end
