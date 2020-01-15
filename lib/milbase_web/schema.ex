defmodule MilbaseWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern
  alias MilbaseWeb.Resolvers
  alias MilbaseWeb.Schema.Middleware

  import_types MilbaseWeb.Schema.Types

  connection node_type: :user_type
  query do
    @desc "Get all users"
    connection field :users, node_type: :user_type do
      middleware(Middleware.Authorize, :any)
      resolve &Resolvers.UserResolver.users/2
    end

    @desc "Get all posts"
    field :posts, list_of(:post_type) do
      middleware(Middleware.Authorize, "user")
      resolve &Resolvers.PostResolver.posts/3
    end

    @desc "Get all comments"
    field :comments, list_of(:comment_type) do
      middleware Middleware.Authorize, "user"
      resolve &Resolvers.CommentResolver.comments/3
    end
  end

  mutation do
    @desc "Register a new user"
    field :register_user, type: :user_type do
      arg(:input, non_null(:user_input_type))
      resolve &Resolvers.UserResolver.register_user/3
    end

    @desc "Login user"
    field :login_user, type: :session_type do
      arg(:input, non_null(:session_input_type))
      resolve &Resolvers.SessionResolver.login_user/3
    end

    @desc "Create post"
    field :create_post, type: :post_type do
      arg(:input, non_null(:post_input_type))
      resolve &Resolvers.PostResolver.create_post/3
    end

    @desc "Create comment"
    field :create_comment, type: :comment_type do
      arg(:input, non_null(:comment_input_type))
      resolve &Resolvers.CommentResolver.create_comment/3
    end
  end
end
