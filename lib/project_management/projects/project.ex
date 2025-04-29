defmodule ProjectManagement.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :name, :string
    field :description, :string
    field :due_date, :date

    has_many :tasks, ProjectManagement.Projects.Task
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description, :due_date])
    |> validate_required([:name, :description, :due_date])
  end
end
