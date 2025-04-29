defmodule ProjectManagement.Projects.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
    field :title, :string
    field :completed, :boolean, default: false

    belongs_to :project, ProjectManagement.Projects.Project

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :project_id])
    |> validate_required([:title, :description, :project_id])
  end
end
