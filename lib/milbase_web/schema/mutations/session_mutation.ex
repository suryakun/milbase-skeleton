defmodule MilbaseWeb.Schema.Mutation.SessionMutation do
  use Absinthe.Schema.Notation
  import AbsintheErrorPayload.Payload
  alias MilbaseWeb.Resolvers

  # Payload for Error payload
  payload_object(:session_payload, :session_type)

  object :session_mutations do
    @desc "login user"
    field :login_user, type: :session_payload, description: "Login user" do
      arg(:input, non_null(:session_input_type))
      resolve &Resolvers.SessionResolver.login_user/3
    end
  end
end
