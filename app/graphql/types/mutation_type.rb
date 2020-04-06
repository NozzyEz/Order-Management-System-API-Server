module Types
  class MutationType < Types::BaseObject
    # Creation mutations
    field :create_user, mutation: Mutations::CreateUser
    field :create_post, mutation: Mutations::CreatePost

    # TODO Updating mutations


    # TODO deletion mutations
  end
end
