defmodule ExPlaces.Config do
  @moduledoc """
  """

  def api_host, do: Application.get_env(:ex_places, :api_host, "https://maps.googleapis.com")

  def base_url, do: api_host <> "/maps/api/place"

  def api_key, do: System.get_env("GOOGLE_MAPS_PLACES_API_KEY")
end

