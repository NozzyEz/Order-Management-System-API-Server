class Mutations::DestroyOrder < Mutations::BaseMutation
    argument :id, Integer, required: true

    type Types::OrderType

    def resolve(id:)
        Order.find(id).destroy
    end
end
