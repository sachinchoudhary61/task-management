defmodule ProjectManagement.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :description, :text
      add :due_date, :date

      timestamps(type: :utc_datetime)
    end
  end
end
