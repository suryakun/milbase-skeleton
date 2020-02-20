defmodule MilbaseWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern
  alias MilbaseWeb.Resolvers
  alias MilbaseWeb.Schema.Middleware
  alias Milbase.{Content, Account}
  import AbsintheErrorPayload.Payload
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  import_types MilbaseWeb.Schema.Types
  import_types AbsintheErrorPayload.ValidationMessageTypes

  # Pagination with Connection
  connection node_type: :user_type

  # Payload for Error payload
  payload_object(:user_payload, :user_type)
  payload_object(:session_payload, :session_type)

  def context(ctx) do
    loader = 
      Dataloader.new()
      |> Dataloader.add_source(Content, Content.data())
      |> Dataloader.add_source(Account, Account.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end 

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
    field :register_user, type: :user_payload, description: "register new user" do
      arg(:input, non_null(:user_input_type))
      resolve &Resolvers.UserResolver.register_user/2
    end

    @desc "Login user"
    field :login_user, type: :session_payload, description: "authenticate user" do
      arg(:input, non_null(:session_input_type))
      resolve &Resolvers.SessionResolver.login_user/3
      #middleware &build_payload/2
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

  subscription do 
    field :comment_added, :comment_type do
      arg :input, non_null(:comment_input_type)

      config fn args, _ -> 
        IO.inspect args.input, label: "argumen topik"
        {:ok, topic: args.input.text}
      end

      trigger :create_comment, topic: fn comment ->
        IO.inspect comment, label: "Data trigger"
        comment.text
      end

      resolve fn comment, _, _ ->
        IO.inspect comment, label: "RETURN"
        {:ok, comment}
      end
    end
  end
end
