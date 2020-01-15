defmodule Milbase.Account.Session do
  alias Milbase.Account.User
  alias Milbase.Repo

  def authenticate(args) do
    user = Repo.get_by(User, email: String.downcase(args.email))
    case check_password(user, args) do
      true -> {:ok, user}
      _ -> {:error, "Incorrect user credential"}
    end
  end

  defp check_password(user, args) do
    case user do
      nil -> Comeonin.Argon2.dummy_checkpw()
      _ -> Comeonin.Argon2.checkpw(args.password, user.password_hash)
    end
  end
end
