defmodule TrackWeb.Router do
  use TrackWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(TrackWeb.Plugs.CurrentUser)
    plug(Turbolinks)
  end

  pipeline :private_browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(TrackWeb.Plugs.CurrentUser)
    plug(TrackWeb.Plugs.Auth)
    plug(Turbolinks)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", TrackWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/user/login", SessionController, :new)
    post("/user/login", SessionController, :create)
    get("/user/register", RegistrationController, :new)
    post("/user/register", RegistrationController, :create)
    post("/user/logout", SessionController, :delete)
  end

  scope "/", TrackWeb do
    # Use the default browser stack
    pipe_through(:private_browser)

    get("/", PageController, :index)
    get("/timesheet", TimesheetController, :index)

    # Logs
    get("/log/new", LogController, :new)
    post("/log/new", LogController, :create)

    # Projects
    get("/projects", ProjectController, :index)
    get("/projects/new", ProjectController, :new)
    post("/projects/new", ProjectController, :create)

    # Clients
    get("/clients", ClientController, :index)
    get("/clients/new", ClientController, :new)
    post("/clients/new", ClientController, :create)
    get("/clients/:id", ClientController, :show)
  end

  # Other scopes may use custom stacks.
  # scope "/api", TrackWeb do
  #   pipe_through :api
  # end
end
