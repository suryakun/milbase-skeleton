defmodule MilbaseWeb.Schema.Types.CommentType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Milbase.Repo

  object :comment_type do
    field :text, :string
    field :user, :user_type, resolve: assoc(:user)
    field :post, :post_type, resolve: assoc(:post)
    field :active, :boolean
  end

  input_object :comment_input_type do
    field :text, non_null(:string)
    field :post_id, non_null(:id)
  end
end
