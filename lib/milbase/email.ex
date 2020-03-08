defmodule Milbase.Email do
  import Bamboo.Email
  import Bamboo.Phoenix

  def welcome_email do
    new_email(
      to: "surya.surakhman@gmail.com",
      from: "surya.ramshere@gmail.com",
      subject: "welcome test absinthe phoenix",
      html_body: "<strong>Welcome absinthe</strong>",
      text_body: "Thanks for joining"
    )
  end

  def reset_token({recipient, token} = params) do
    link = System.get_env("CLIENT_HOST") <> "reset_password?email=" <> recipient <> "&token=" <> token 
    new_email(
      to: recipient,
      from: System.get_env("EMAIL_USERNAME"),
      subject: "Reset password",
      html_body: "<strong>Silahkan klik link berikut ini untuk reset ulang password anda </strong>" <> link,
      text_body: "You are awesome"
    )
  end

end
