# ProjectManagement

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

# Project Management Application - Setup Instructions

This Phoenix application allows managing **Projects** and their **Tasks**.
Each Project has:
- Name
- Description
- Due Date

Each Project has many Tasks:
- Title
- Description
- Completed (checkbox)

All Task routes are nested under Project routes.

---

## How to Create This Project from Scratch

### 1. Create the Phoenix Project
```bash
mix phx.new project_management --database postgres
cd project_management
mix deps.get
```

### 2. Setup the Database
```bash
mix ecto.create
```

### 3. Generate Project Module
```bash
mix phx.gen.html Projects Project projects name:string description:text due_date:date
```

### 4. Generate Task Module (nested under Project)
```bash
mix phx.gen.html Projects Task tasks title:string description:text completed:boolean project_id:references:projects
```

### 5. Run Migrations
```bash
mix ecto.migrate
```

### 6. Update Associations
- In `project.ex`:
  ```elixir
  has_many :tasks, ProjectManagement.Projects.Task
  ```
- In `task.ex`:
  ```elixir
  belongs_to :project, ProjectManagement.Projects.Project
  ```

### 7. Update Router
In `lib/project_management_web/router.ex`:
```elixir
scope "/", ProjectManagementWeb do
  pipe_through :browser

  resources "/projects", ProjectController do
    resources "/tasks", TaskController
  end
end
```

### 8. Update Context Functions in `projects.ex`
Add:
- `create_task/2`
- `get_task!/2`

Example:
```elixir
def create_task(%Project{} = project, attrs) do
  %Task{}
  |> Task.changeset(Map.put(attrs, "project_id", project.id))
  |> Repo.insert()
end

def get_task!(%Project{} = project, id) do
  Repo.get_by!(Task, id: id, project_id: project.id)
end
```

### 9. Fix All Templates
Ensure all task links include `project_id`, for example:
```elixir
<.link href={~p"/projects/#{@project.id}/tasks/#{task.id}"}>Show</.link>
```

### 10. Run the Application
```bash
mix phx.server
```
Access the app at:
```
http://localhost:4000/projects
```

---
## Demo Video
[Click here to watch the demo on YouTube](https://www.youtube.com/watch?v=-nD04BGGbyA)

After following these steps, you will have a working **Project Management** Phoenix application with nested **Tasks** support!
