defmodule TrackWeb.Router do
  use TrackWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Turbolinks
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TrackWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello/:name", PageController, :hello
  end

  # Other scopes may use custom stacks.
  # scope "/api", TrackWeb do
  #   pipe_through :api
  # end
end
