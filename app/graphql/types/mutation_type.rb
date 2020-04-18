module Types
  class MutationType < Types::BaseObject

    # TODO: Create fields for organizations, orders and products 
    # Registering and Signing In
    field :register_user, mutation: Mutations::RegisterUser
    field :sign_in, mutation: Mutations::SignIn

    # Creation mutations
    field :create_user, mutation: Mutations::CreateUser
    field :create_organization, mutation: Mutations::CreateOrganization
    field :create_product, mutation: Mutations::CreateProduct
    field :create_order, mutation: Mutations::CreateOrder

    # Updating mutations
    field :update_user, mutation: Mutations::UpdateUser
    field :update_organization, mutation: Mutations::UpdateOrganization
    field :update_product, mutation: Mutations::UpdateProduct
    field :update_order, mutation: Mutations::UpdateOrder


    # deletion mutations
    field :destroy_user, mutation: Mutations::DestroyUser
    field :destroy_organization, mutation: Mutations::DestroyOrganization
    field :destroy_product, mutation: Mutations::DestroyProduct
    field :destroy_order, mutation: Mutations::DestroyOrder
  end
end
