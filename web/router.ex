defmodule ParkApi.Router do
  use ParkApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ParkApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ParkApi do
    pipe_through :api

    resources "/games", GameController, except: [:new, :edit]
    resources "/parks", ParkController, except: [:new, :edit]
  end
end
