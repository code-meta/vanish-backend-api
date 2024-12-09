defmodule VanishApi.Repo do
  use Ecto.Repo,
    otp_app: :vanish_api,
    adapter: Ecto.Adapters.Postgres
end
