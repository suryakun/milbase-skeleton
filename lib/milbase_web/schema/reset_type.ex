defmodule MilbaseWeb.Schema.Types.ResetType do
  use Absinthe.Schema.Notation

  input_object :reset_verify_input_type do
    field :token, non_null(:string)
    field :email, non_null(:string)
  end

  object :reset_verify_type do
    field :token, :string
    field :email, :string
  end

  object :reset_token_type do
    field :token, :string
    field :email, :string
  end

  input_object :reset_input_type do
    field :email, non_null(:string)
  end
end
