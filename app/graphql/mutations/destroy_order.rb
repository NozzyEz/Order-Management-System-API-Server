class Mutations::DestroyOrder < Mutations::BaseMutation
    argument :id, Integer, required: true

    type Types::OrderType

    def resolve(id:)
        authorize_user
        Order.find(id).destroy
    end
end
