defmodule Sso.Auth.Pipeline do
  @moduledoc """
  Guardian Pipeline

  This is a pipeline that can be used in the phoenix
  router to use Guardian
  """

  use Guardian.Plug.Pipeline,
    otp_app: :sso,
    error_handler: Sso.Auth.ErrorHandler,
    module: Sso.Auth.Guardian

  # If there is a session token, validate it
  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  # Load the credential if the session token was validated
  plug(Guardian.Plug.LoadResource, allow_blank: true)
  # Assign the current_user (for the loaded credential)
  plug(SsoWeb.Plug.CurrentCredential)
end
