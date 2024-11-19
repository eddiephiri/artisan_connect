defmodule ArtisanConnect.Repo do
  use Ecto.Repo,
    otp_app: :artisan_connect,
    adapter: Ecto.Adapters.Postgres
end
