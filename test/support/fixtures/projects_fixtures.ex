defmodule ProjectManagement.ProjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ProjectManagement.Projects` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        description: "some description",
        due_date: ~D[2025-04-28],
        name: "some name"
      })
      |> ProjectManagement.Projects.create_project()

    project
  end

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        completed: true,
        description: "some description",
        title: "some title"
      })
      |> ProjectManagement.Projects.create_task()

    task
  end
end
