defmodule Milbase.Repo.Migrations.AddActiveColumnUser do
  use Ecto.Migration

  def change do
    alter table("users") do
      add_if_not_exists :active, :bool, default: true
    end
  end
end
