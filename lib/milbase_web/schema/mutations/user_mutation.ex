defmodule MilbaseWeb.Schema.Mutation.UserMutation do
  use Absinthe.Schema.Notation
  import AbsintheErrorPayload.Payload
  alias MilbaseWeb.Schema.Middleware
  alias MilbaseWeb.Resolvers

  payload_object(:user_payload, :user_type)

  object :user_mutations do
    field :register_user, type: :user_payload, description: "register new user" do
      arg(:input, non_null(:user_input_type))
      resolve &Resolvers.UserResolver.register_user/2
    end
  end
end
