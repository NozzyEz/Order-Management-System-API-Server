module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    def authorize_user
      return true if context[:current_user].present?

      raise GraphQL::ExecutionError, "User not signed in"
    end
  end
end