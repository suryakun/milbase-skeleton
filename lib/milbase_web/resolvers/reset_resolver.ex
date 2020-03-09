defmodule MilbaseWeb.Resolvers.ResetResolver do
  alias Milbase.{Account, Guardian, Email, Mailer}
  alias MilbaseWeb.ErrorHelpers, as: Helper
  alias AbsintheErrorPayload.ValidationMessage
  alias Milbase.Account.User
  import AbsintheErrorPayload.Payload
  import Ecto.Query, only: [from: 2]

  def send_token(_, %{input: input}, _) do
    with {:ok, user} <- Account.get_by_email(input.email),
         {:ok, jwt_token, _} <- Guardian.encode_and_sign(user) do
      try do
        g = Gatka.hello
        IO.inspect g
        {user.email, jwt_token} |> Email.reset_token |> Mailer.deliver_now()
        {:ok, success_payload(%{token: jwt_token, email: user.email})}
      rescue
        error in Bamboo.SMTPAdapter.SMTPError ->
        {:ok, [%ValidationMessage{field: "reset", code: "RESET001", message: "Cannot send the email"}]
        |> Helper.validate_translate()
        |> error_payload()
        }
      end
    else
      {:error, message} -> {:ok, [%ValidationMessage{field: "reset", code: "RESET001", message: "Cannot find your email"}]
      |> Helper.validate_translate()
      |> error_payload()
      }
    end
  end
end
