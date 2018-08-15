defmodule SsoWeb.CredentialView do
  use SsoWeb, :view

  def render("show.json", %{credential: credential}) do
    %{
      email: credential.email,
      sso_id: credential.sso_id
    }
  end
end
