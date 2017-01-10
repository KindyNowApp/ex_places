defmodule ExPlaces.HTTP do

  @moduledoc false

  alias ExPlaces.Config
  alias ExPlaces.Helper

  @spec get(map, String.t) :: {atom, map}
  def get(request, path) do
    Config.base_url <> path
    |> HTTPoison.get([], [params: request])
    |> parse_response
  end

  @spec parse_response({atom, map}) :: {atom, any}
  def parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    {:ok, parse_json(body)}
  end

  def parse_response({:error, %HTTPoison.Error{id: _id, reason: reason}}) do
    {:error, reason}
  end

  def parse_json(json) do
    json
    |> Poison.decode!
    |> Helper.atomise_keys
  end

  @spec attach_api_key(Request.t) :: Request.t
  def attach_api_key(request) do
    Map.put(request, :key, Config.api_key)
  end

end
