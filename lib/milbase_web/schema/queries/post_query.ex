defmodule MilbaseWeb.Schema.Query.PostQuery do
  use Absinthe.Schema.Notation
  alias MilbaseWeb.Schema.Middleware
  alias MilbaseWeb.Resolvers

  object :post_queries do
    @desc "Query all posts"
    field :posts, type: list_of(:post_type) do
      middleware(Middleware.Authorize, :any)
      resolve &Resolvers.PostResolver.posts/3
    end
  end


end
