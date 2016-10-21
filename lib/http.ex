defmodule ExPlaces.HTTP do
  alias __MODULE__
  alias ExPlaces.Config
  alias ExPlaces.Helper

  import Poison, only: [decode: 1]

  @spec get(map, String.t) :: {atom, map}
  def get(request, path) do
    Config.base_url <> path
    |> HTTPoison.get([], [params: request])
    |> parse_response
  end

  def parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    {:ok, parse_json(body)}
  end

  def parse_response({:error, %HTTPoison.Error{id: _id, reason: reason }}) do
    {:error, reason}
  end

  def parse_response(response) do
    response
  end

  def parse_json(json) do
    response =
      json
      |> decode
      |> atomise_keys
  end

  @spec atomise_keys({atom, map}) :: map
  defp atomise_keys({:ok, response}) do
    Helper.atomise_keys(response)
  end

  @spec attach_api_key(Request.t) :: Request.t
  def attach_api_key(request) do
    Map.put(request, :key, Config.api_key)
  end
end
