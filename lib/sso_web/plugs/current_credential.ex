defmodule SsoWeb.Plug.CurrentCredential do
  import Plug.Conn

  @moduledoc """
  This plug queries the current credential from Guardian and puts it into the :current_credential assign in the conn.
  """
  use Plug.Builder
  plug(Plug.Logger)

  def call(conn, _opts) do
    credential = Guardian.Plug.current_resource(conn)
    assign(conn, :current_credential, credential)
  end
end
