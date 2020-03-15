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
        {user.email, jwt_token} |> Email.reset_token |> Mailer.deliver_now()
        Gatka.store_token(user.email, jwt_token)
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

  def verify_token(_, %{input: input}, _) do
    with {:ok, user} <- Account.get_by_email(input.email),
         {:ok, true} <- Gatka.check_token(user.email) do
      {:ok, success_payload(%{token: input.token, email: input.email})}
    else
      {:error, _message} -> {:ok, [%ValidationMessage{field: "unauthorized_reset", code: "RESET002", message: "Unauthorized token"}]
      |> Helper.validate_translate()
      |> error_payload()
      }
    end
  end

  def reset_password(_, %{input: input}, _) do
    with {:ok, token} <- Gatka.get_token(input.email),
         {:ok, claims} <- Guardian.decode_and_verify(input.token),
         {:ok, user} <- Guardian.resource_from_claims(claims),
         {:ok, _key} <- Gatka.delete_token(user.email) do
      if token == input.token do
        {:ok, user} = Account.update_user(user, %{password: input.password, password_confirmation: input.password_confirmation})
        {:ok, success_payload(%{email: user.email})}
      else
        {:ok, [%ValidationMessage{field: "invalid_token", code: "RESET004", message: "Invalid Token"}]
        |> Helper.validate_translate()
        |> error_payload()
        }
      end
    else
      {:error, _message} -> {:ok, [%ValidationMessage{field: "unauthorized_reset", code: "RESET003", message: "unauthorized token"}]
      |> Helper.validate_translate()
      |> error_payload()
      }
    end
  end
end
