defmodule MilbaseWeb.Schema.Types.ResetType do
  use Absinthe.Schema.Notation

  object :reset_token_type do
    field :token, :string
  end

  input_object :reset_input_type do
    field :email, non_null(:string)
  end
end
