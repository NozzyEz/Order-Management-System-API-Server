class Mutations::DestroyPost < Mutations::BaseMutation
    argument :id, Integer, required: true

    # field :post,    Types::PostType,    null: true
    # field :errors,  [String],           null: true

    type Types::PostType

    def resolve(id:)
        Post.find(id).destroy
    end
end
