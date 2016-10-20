defmodule ExPlaces.Request do
  @moduledoc """
  A Google Maps Places request
  """

  alias __MODULE__
  alias ExPlaces.Config

  defstruct input: nil, # required
    types: nil, # geocode, address or establishment
    offset: nil,
    radius: nil,
    language: nil,
    components: nil,
    key: nil # required

  @type t :: %__MODULE__{}

  def places_autocomplete(%Request{} = request) do
    request
    |> attach_api_key
    |> Map.from_struct
    |> Enum.filter(fn {_, v} -> v != nil end) #remove nil values
    |> get("/autocomplete/json")
  end

  def place_by_id(place_id) do

  end

  @spec get(map, String.t) :: {atom, map}
  def get(request, path) do
    Config.base_url <> path
    |> HTTPoison.get([], [params: request])
    |> parse_response
  end

  def parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    # {:ok, Response.parse(body)}
    {:ok, body}
  end

  def parse_response({:error, %HTTPoison.Error{id: _id, reason: reason }}) do
    {:error, reason}
  end

  def parse_response(response) do
    response
  end

  @spec attach_api_key(Request.t) :: Request.t
  def attach_api_key(%Request{} = request) do
    %Request{request | key: Config.api_key}
  end
end
