defmodule Sso.Auth.ErrorHandler do
  @moduledoc """
  Guardian Error Handling

  This is a module that is used alongside the
  Guardian impelemenation module and pipeline
  for handling errors.
  """
  import Plug.Conn, only: [halt: 1]
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def auth_error(conn, {_unauthenticated, _reason}, _opts) do
    conn
    # |> Plug.Conn.put_session(:redirect_after_login_path, conn.request_path)
    |> redirect_with_flash_message("You must be logged in.")
  end

  defp redirect_with_flash_message(conn, message) do
    conn
    |> put_flash(:error, message)
    |> redirect(to: SsoWeb.Router.Helpers.session_path(conn, :new))
    |> halt()
  end
end
