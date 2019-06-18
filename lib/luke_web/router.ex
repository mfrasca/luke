defmodule LukeWeb.Router do
  use LukeWeb, :router

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

  scope "/", LukeWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", LukeWeb do
    pipe_through :api
    resources "/taxon", TaxonController
    resources "/accession", AccessionController
    resources "/plant", PlantController
    resources "/location", LocationController
  end

  # Other scopes may use custom stacks.
  scope "/url", LukeWeb do
    pipe_through :api

    get "/count", CountController, :index
  end
end
