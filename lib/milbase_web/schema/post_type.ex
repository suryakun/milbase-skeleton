defmodule MilbaseWeb.Schema.Types.PostType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Milbase.Repo
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :post_type do
    field :id, :id
    field :content, :string
    field :user, :user_type, resolve: dataloader(Milbase.Account)
    field :active, :boolean
  end

  input_object :post_input_type do
    field :content, non_null(:string)
    field :active, non_null(:boolean)
  end

end
