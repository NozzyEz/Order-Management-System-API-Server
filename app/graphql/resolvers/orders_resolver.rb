module Resolvers
  class OrdersResolver < GraphQL::Schema::Resolver
    type [Types::OrderType], null: false

    argument :created_at, GraphQL::Types::ISO8601Date, required: false

    def resolve(created_at: nil)
        raise GraphQL::ExecutionError, "User not signed in" unless context[:current_user]

        current_user = context[:current_user]

        scope =
            if current_user.admin?
                Order.all
            elsif current_user.superuser?
                Order.where(organization_id: current_user.organization_id) # pretend we scoped
            else
                current_user.orders
            end

      
      scope = scope.where(created_at: created_at.beginning_of_day..created_at.end_of_day) if created_at

      scope
    end
  end
end