defmodule SsoWeb.Router do
  use SsoWeb, :router

  pipeline :ensure_authenticated do
    plug(Guardian.Plug.EnsureAuthenticated)
    plug(Guardian.Plug.LoadResource)
  end

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(JointRegistry.Auth.Pipeline)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", SsoWeb do
    # Use the default browser stack
    pipe_through(:browser)

    resources("/credentials", CredentialController, only: [:new, :create])

    pipe_through(:ensure_authenticated)
    get("/", CredentialController, :index)
    resources("/credentials", CredentialController, except: [:new, :create])
  end

  # Other scopes may use custom stacks.
  scope "/api", SsoWeb do
    pipe_through(:api)

    get("/credentials/show", CredentialController, :api_show)
  end
end
