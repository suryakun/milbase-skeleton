defmodule Milbase.Content.Post do
  use Ecto.Schema
  alias Milbase.Account.User
  import Ecto.Changeset

  schema "posts" do
    field :active, :boolean, default: false
    field :content, :string
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:content, :active, :user_id])
    |> validate_required([:content, :active, :user_id])
  end
end
