defmodule NewApp.Repo do
  use Ecto.Repo,
    otp_app: :new_app,
    adapter: Ecto.Adapters.Postgres
end
