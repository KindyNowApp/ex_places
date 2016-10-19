defmodule ExPlaces.Request do
  @moduledoc """
  A Google Maps Places request
  """

  alias __MODULE__
  alias ExGeocode.Config
  alias ExGeocode.ComponentFilters
  alias ExGeocode.Response

  defstruct input: nil

  @type t :: %__MODULE__{}

  def places_autocomplete(input) do
    %Request{input: input} |> places_autocomplete
  end

  @spec get(map) :: {atom, map}
  def get(request) do
    Config.base_url
    |> HTTPoison.get([], [params: request])
    |> parse_response
  end

  def parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    {:ok, Response.parse(body)}
  end

  def parse_response({:error, %HTTPoison.Error{id: _id, reason: reason }}) do
    {:error, reason}
  end

  @spec attach_api_key(Request.t) :: Request.t
  def attach_api_key(%Request{} = request) do
    %Request{request | key: Config.api_key}
  end
end
