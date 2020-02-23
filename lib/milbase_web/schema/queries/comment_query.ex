defmodule MilbaseWeb.Schema.Query.CommentQuery do
  use Absinthe.Schema.Notation
  alias MilbaseWeb.Schema.Middleware
  alias MilbaseWeb.Resolvers

  object :comment_queries do
    @desc "Query all comments"
    field :comments, type: list_of(:comment_type) do
      middleware(Middleware.Authorize, "user")
      resolve &Resolvers.CommentResolver.comments/3
    end
  end
end
