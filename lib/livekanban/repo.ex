defmodule Livekanban.Repo do
  use Ecto.Repo,
    otp_app: :livekanban,
    adapter: Ecto.Adapters.Postgres
end
