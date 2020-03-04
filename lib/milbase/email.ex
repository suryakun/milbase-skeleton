defmodule Milbase.Email do
  import Bamboo.Email
  import Bamboo.Phoenix

  def welcome_email do
    new_email(
      to: "surya.ramshere@gmail.com",
      from: "milbase@localhost",
      subject: "welcome test absinthe phoenix",
      html_body: "<strong>Welcome absinthe</strong>",
      text_body: "Thanks for joining"
    )
  end

end
