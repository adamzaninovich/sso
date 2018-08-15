defmodule Sso.Auth.Guardian do
  @moduledoc """
  Guardian implementation module

  This module is a part of the setup required
  for using Guardian and is a place where
  guardian hooks can be implemented.
  """
  use Guardian, otp_app: :sso

  alias Sso.Credentials
  alias Sso.Credentials.Credential

  def subject_for_token(%Credential{} = credential, _claims), do: {:ok, to_string(credential.id)}
  def subject_for_token(_, _), do: {:error, :unknown_resource_type}

  def resource_from_claims(%{"sub" => credential_id}) do
    case Credentials.get_credential!(credential_id) do
      nil -> {:error, :unknown_resource_type}
      credential -> {:ok, credential}
    end
  end

  def resource_from_claims(_claims), do: {:error, :unknown_resource_type}
end
