module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    # Same method as in QueryType, to check if a user is logged in when they perform a mutation
    # we store it here so every mutation (that needs it) can call it in their resolve function
    def authenticate_user
      return true if context[:current_user].present?

      raise GraphQL::ExecutionError, "User not signed in"
    end
  end
end