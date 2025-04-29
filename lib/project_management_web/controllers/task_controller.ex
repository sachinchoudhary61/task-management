defmodule ProjectManagementWeb.TaskController do
  use ProjectManagementWeb, :controller

  alias ProjectManagement.Projects
  alias ProjectManagement.Projects.Task

  def index(conn, %{"project_id" => project_id}) do
    project = Projects.get_project!(project_id)
    tasks = Projects.list_tasks()
    render(conn, :index, tasks: tasks, project: project)
  end

  def new(conn, %{"project_id" => project_id}) do
    project = Projects.get_project!(project_id)
    changeset = Projects.change_task(%Task{project_id: project.id})
    render(conn, :new, changeset: changeset, project: project)
  end

  def create(conn, %{"project_id" => project_id, "task" => task_params}) do
    project = Projects.get_project!(project_id)

    case Projects.create_task(project, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: ~p"/projects/#{project.id}/tasks/#{task.id}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset, project: project)
    end
  end

  def show(conn, %{"project_id" => project_id, "id" => id}) do
    project = Projects.get_project!(project_id)
    task = Projects.get_task!(project, id)
    render(conn, :show, task: task)
  end

  def edit(conn, %{"id" => id, "project_id" => project_id}) do
    project = Projects.get_project!(project_id)
    task = Projects.get_task!(project, id)
    changeset = Projects.change_task(task)

    project = Projects.get_project!(project_id)
    render(conn, :edit, task: task, changeset: changeset, project: project)
  end

  def update(conn, %{"project_id" => project_id, "id" => id, "task" => task_params}) do
    project = Projects.get_project!(project_id)
    task = Projects.get_task!(project, id)

    case Projects.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: ~p"/projects/#{project.id}/tasks/#{task.id}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, task: task, changeset: changeset, project: project)
    end
  end

  def delete(conn, %{"project_id" => project_id, "id" => id}) do
    project = Projects.get_project!(project_id)
    task = Projects.get_task!(project, id)
    {:ok, _task} = Projects.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: ~p"/projects/#{project.id}/tasks")
  end
end
