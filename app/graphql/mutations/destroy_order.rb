class Mutations::DestroyOrder < Mutations::BaseMutation
    argument :id, Integer, required: true

    type Types::OrderType

    def resolve(id:)
        authenticate_user
        Order.find(id).destroy
    end
end
