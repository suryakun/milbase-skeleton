defmodule MilbaseWeb.Resolvers.UserResolver do
  alias Milbase.Repo
  alias Absinthe.Relay.Connection
  alias Milbase.Account.User
  alias Milbase.Account

  def users(pagination_arg, %{context: context}) do
    IO.inspect pagination_arg
    IO.inspect context
    Connection.from_query(User, &Repo.all/1, pagination_arg)

    # Uncomment this if you want to fetch the users without pagination
    #{:ok, Account.list_users()}
  end

  def register_user(_, %{input: input}, _) do
    Account.create_user(input)
  end
  
end
