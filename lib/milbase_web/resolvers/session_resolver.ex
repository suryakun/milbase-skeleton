defmodule MilbaseWeb.Resolvers.SessionResolver do
  alias Milbase.{Account, Guardian}
  alias MilbaseWeb.ErrorHelpers, as: Helper
  alias AbsintheErrorPayload.ValidationMessage
  import AbsintheErrorPayload.Payload

  def login_user(_, %{input: input}, _) do
    with {:ok, user} <- Account.Session.authenticate(input),
         {:ok, jwt_token, _} <- Guardian.encode_and_sign(user) do
         {:ok, success_payload(%{token: jwt_token, user: user})}
    else
      {:error, message} -> {:ok, [%ValidationMessage{
          field: :user,
          code: "B1234",
          message: message}]
          |> Helper.validate_translate()
          |> error_payload()
      }
    end
  end
end
