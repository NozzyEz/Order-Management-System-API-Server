module Types
  class MutationType < Types::BaseObject

    # TODO: Create fields for organizations, orders and products 

    # Creation mutations
    field :create_user, mutation: Mutations::CreateUser
    field :create_organization, mutation: Mutations::CreateOrganization

    # Updating mutations
    field :update_user, mutation: Mutations::UpdateUser
    field :update_organization, mutation: Mutations::UpdateOrganization


    # deletion mutations
    field :destroy_user, mutation: Mutations::DestroyUser
    field :destroy_organization, mutation: Mutations::DestroyOrganization
  end
end
