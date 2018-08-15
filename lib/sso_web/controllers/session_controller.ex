defmodule SsoWeb.SessionController do
  use SsoWeb, :controller

  # def new(%{assigns: %{current_user: %User{}}} = conn, _) do
  #   redirect(conn, to: user_path(conn, :index))
  # end
  #
  # plug(:put_layout, "blank.html")

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"credential" => %{"email" => email, "password" => password}}) do
    case Credentials.validate(email, password) do
      {:ok, credential} ->
        conn
        |> Sso.Auth.Guardian.Plug.sign_in(credential)
        |> redirect(to: return_path(conn))

      {:error, _message} ->
        conn
        |> put_flash(:error, "Bad email/password combination")
        |> redirect(to: session_path(conn, :new))
    end
  end

  def delete(conn, _) do
    conn
    |> Sso.Auth.logout()
    |> redirect(to: "/")
  end

  def return_path(conn) do
    :ok
  end
end
