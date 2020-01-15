defmodule Milbase.Content.Comment do
  use Ecto.Schema
  alias Milbase.Account.User
  alias Milbase.Content.Post
  import Ecto.Changeset

  schema "comments" do
    field :text, :string
    belongs_to :user, User
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text, :post_id, :user_id])
    |> validate_required([:text, :post_id, :user_id])
  end
end
