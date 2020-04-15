class Mutations::DestroyProduct < Mutations::BaseMutation
    argument :id, Integer, required: true

    # field :post,    Types::PostType,    null: true
    # field :errors,  [String],           null: true

    type Types::ProductType

    def resolve(id:)
        Product.find(id).destroy
    end
end
