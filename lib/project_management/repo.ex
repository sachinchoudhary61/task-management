defmodule ProjectManagement.Repo do
  use Ecto.Repo,
    otp_app: :project_management,
    adapter: Ecto.Adapters.Postgres
end
