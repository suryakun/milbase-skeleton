defmodule MilbaseWeb.Schema.Mutation.ResetMutation do
  use Absinthe.Schema.Notation
  import AbsintheErrorPayload.Payload
  alias MilbaseWeb.Resolvers

  payload_object(:reset_token_payload, :reset_token_type)

  object :reset_mutations do
    field :send_token, type: :reset_token_payload do
      arg(:input, non_null(:reset_input_type))
      resolve &Resolvers.ResetResolver.send_token/3
    end
  end
end
