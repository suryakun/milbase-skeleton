defmodule Milbase.Repo.Migrations.AddActiveComment do
  use Ecto.Migration

  def change do
    alter table("comments") do
      add_if_not_exists :active, :bool, default: true
    end
  end
end
