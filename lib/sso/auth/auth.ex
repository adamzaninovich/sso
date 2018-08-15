defmodule Sso.Auth do
  @moduledoc "Auth Module"

  def logout(conn) do
    conn
    |> Plug.Conn.assign(:current_credential, nil)
    |> Sso.Auth.Guardian.Plug.sign_out()
  end
end
