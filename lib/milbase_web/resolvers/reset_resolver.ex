defmodule MilbaseWeb.Resolvers.ResetResolver do
  alias Milbase.{Repo, Guardian, Email, Mailer}
  alias MilbaseWeb.ErrorHelpers, as: Helper
  alias AbsintheErrorPayload.ValidationMessage
  alias Milbase.Account.User
  import AbsintheErrorPayload.Payload
  import Ecto.Query, only: [from: 2]

  def send_token(_, %{input: input}, _) do
    query = from u in User, where: u.email == ^input.email, select: u
    with user <- Repo.one(query),
         {:ok, jwt_token, _} <- Guardian.encode_and_sign(user) do
      Email.welcome_email |> Mailer.deliver_now()
      {:ok, success_payload(%{token: jwt_token})}
    else
      {:error, message} -> {:ok, [%ValidationMessage{field: "reset", code: "RESET001", message: "Cannot find your email"}]
      |> Helper.validate_translate()
      |> error_payload()
      }
    end
  end
end
