defmodule TrackWeb.Router do
  use TrackWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(Turbolinks)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", TrackWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)

    get("/user", UserController, :index)
    get("/user/login", SessionController, :new)
    post("/user/login", SessionController, :create)
    get("/user/register", RegistrationController, :new)
    post("/user/register", RegistrationController, :create)

    get("/timesheet", TimesheetController, :index)

    get("/entry/new", LogController, :new)
    post("/entry/new", LogController, :create)
    get("/projects", ProjectController, :index)
    get("/projects/new", ProjectController, :new)
    post("/projects/new", ProjectController, :create)
    get("/clients", ClientController, :index)
    get("/clients/new", ClientController, :new)
    post("/clients/new", ClientController, :create)
  end

  # Other scopes may use custom stacks.
  # scope "/api", TrackWeb do
  #   pipe_through :api
  # end
end
