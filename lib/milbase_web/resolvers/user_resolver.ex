defmodule MilbaseWeb.Resolvers.UserResolver do
  alias Milbase.Repo
  alias Absinthe.Relay.Connection
  alias Milbase.Account.User
  alias Milbase.Account
  alias MilbaseWeb.ErrorHelpers, as: Helper
  import AbsintheErrorPayload.Payload
  import AbsintheErrorPayload.ChangesetParser

  def users(pagination_arg, %{context: context}) do
    IO.inspect pagination_arg
    IO.inspect context
    Connection.from_query(User, &Repo.all/1, pagination_arg)

    # Uncomment this if you want to fetch the users without pagination
    #{:ok, Account.list_users()}
  end

  def register_user(%{input: input}, _) do
    case Account.create_user(input) do
      {:ok, user} -> {:ok, success_payload(user)}
      {:error, %Ecto.Changeset{} = changeset} -> 
        {:ok, changeset 
        |> extract_messages() 
        |> Helper.validate_translate()
        |> error_payload() }
    end
  end
  
end
