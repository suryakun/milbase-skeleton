defmodule MilbaseWeb.Resolvers.SessionResolver do
  alias Milbase.{Account, Guardian}

  def login_user(_, %{input: input}, _) do
    with {:ok, user} <- Account.Session.authenticate(input),
         {:ok, jwt_token, _} <- Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt_token, user: user}}
    end
  end
end
