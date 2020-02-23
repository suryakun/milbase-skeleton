defmodule MilbaseWeb.Schema do
  use Absinthe.Schema
  alias MilbaseWeb.Resolvers
  alias Milbase.{Content, Account}

  import_types MilbaseWeb.Schema.Types
  import_types AbsintheErrorPayload.ValidationMessageTypes


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
    @desc "query all users"
    import_fields :user_queries
    
    @desc "query all posts"
    import_fields :post_queries

    @desc "Get all comments"
    import_fields :comment_queries
  end

  mutation do
    @desc "Register new user"
    import_fields :user_mutations

    @desc "Login user"
    import_fields :session_mutations

    @desc "Create post"
    import_fields :post_mutations

    @desc "Create comment"
    import_fields :comment_mutations
  end

  subscription do 
    @desc "notification comment added"
    import_fields :comment_subscriptions
  end
end
