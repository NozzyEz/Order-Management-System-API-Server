require 'search_object'
require 'search_object/plugin/graphql'

module Resolvers
    class OrdersSearch
        
        
        include SearchObject.module(:graphql)

        scope { Order.all }

        type types[Types::OrderType]

        class OrderFilter < ::Types::BaseInputObject
            argument :OR,          [self],                      required: false
            argument :created_at,  GraphQL::Types::ISO8601Date, required: false
        end

        option :filter, type: OrderFilter, with: :apply_filter

        def current_user
            current_user = context[:current_user]
        end

        def authenticate_user
            return true if current_user.present?
      
            raise GraphQL::ExecutionError, "User not signed in"
        end

        binding.pry
        authenticate_user

        def apply_filter(scope, value)
            branches = normalize_filters(value).reduce { |a, b| a.or(b)}
            scope.merge branches
        end

        def normalize_filters(value, branches = [])
            scope = Order.all
            scope = scope.where(created_at: value[:created_at].beginning_of_day..value[:created_at].end_of_day) if value[:created_at]

            branches << scope

            value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

            branches
        end
    end
end