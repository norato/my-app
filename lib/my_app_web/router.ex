defmodule MyAppWeb.Router do
  use MyAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :api_auth do
    plug :ensure_authentication
  end

  scope "/api", MyAppWeb do
    pipe_through :api
    post "/users/sign_in", UserController, :sign_in
  end

  scope "/api", MyAppWeb do
    pipe_through [:api, :api_auth]
    resources "/users", UserController, except: [:new, :edit]
  end

  def ensure_authentication(conn, _opts) do
    current_user_id = get_session(conn, :current_user_id)

    if current_user_id do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> render(MyAppWeb.ErrorView, "401.json", message: "Unauthozired user")
    end
  end
end
