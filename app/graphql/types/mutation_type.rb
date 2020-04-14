module Types
  class MutationType < Types::BaseObject

    # TODO: Create fields for organizations, orders and products 
    # TODO: Remove fields for posts

    # Creation mutations
    field :create_user, mutation: Mutations::CreateUser
    # field :create_post, mutation: Mutations::CreatePost

    # Updating mutations
    field :update_user, mutation: Mutations::UpdateUser
    # field :update_post, mutation: Mutations::UpdatePost


    # deletion mutations
    field :destroy_user, mutation: Mutations::DestroyUser
    # field :destroy_post, mutation: Mutations::DestroyPost
  end
end
