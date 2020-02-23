defmodule MilbaseWeb.Schema.Query.UserQuery do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema, :modern
  alias MilbaseWeb.Resolvers
  alias MilbaseWeb.Schema.Middleware
    
  # Pagination with Connection
  connection node_type: :user_type

  object :user_queries do
    @desc "Get all users"
    connection field :users, node_type: :user_type do
      middleware(Middleware.Authorize, :any)
      resolve &Resolvers.UserResolver.users/2
    end
  end
end
