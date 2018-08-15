defmodule SsoWeb.Plug.ClientReturnPath do
  import Plug.Conn

  use Plug.Builder
  plug(Plug.Logger)

  def call(
        %{params: %{"client_continue" => continue, "client_create_user" => create_user}} = conn,
        _opts
      ) do
    put_session(conn, :client_paths, %{continue: continue, create_user: create_user})
  end

  def call(conn, _opts) do
    conn
  end
end
