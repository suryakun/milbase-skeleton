defmodule MilbaseWeb.Router do
  use MilbaseWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "http://localhost:3000"
    plug :accepts, ["json"]
    plug MilbaseWeb.Plugs.Context
  end

  scope "/api" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug, schema: MilbaseWeb.Schema

    if Mix.env() == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL, schema: MilbaseWeb.Schema
    end
  end
end
