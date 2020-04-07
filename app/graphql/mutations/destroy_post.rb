class Mutations::DestroyPost < Mutations::BaseMutation
    argument :id, Integer, required: true

    field :post,    Types::PostType,    null: true
    field :errors,  [String],           null: true

    def resolve(id:)
        Post.find(id).destroy

    end
end