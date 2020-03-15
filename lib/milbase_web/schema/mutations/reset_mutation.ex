defmodule MilbaseWeb.Schema.Mutation.ResetMutation do
  use Absinthe.Schema.Notation
  import AbsintheErrorPayload.Payload
  alias MilbaseWeb.Resolvers

  payload_object(:reset_token_payload, :reset_token_type)
  payload_object(:reset_verify_payload, :reset_verify_type)
  payload_object(:reset_password_payload, :reset_password_type)

  object :reset_mutations do
    field :send_token, type: :reset_token_payload do
      arg(:input, non_null(:reset_input_type))
      resolve &Resolvers.ResetResolver.send_token/3
    end
  end

  object :reset_verify_mutations do
    field :reset_verify, type: :reset_verify_payload do
      arg(:input, non_null(:reset_verify_input_type))
      resolve &Resolvers.ResetResolver.verify_token/3
    end
  end

  object :reset_password_mutations do
    field :reset_password, type: :reset_password_payload do
      arg(:input, non_null(:reset_password_input_type))
      resolve &Resolvers.ResetResolver.reset_password/3
    end
  end
end
