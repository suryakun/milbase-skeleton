defmodule Milbase.Repo do
  use Ecto.Repo,
    otp_app: :milbase,
    adapter: Ecto.Adapters.Postgres
end
