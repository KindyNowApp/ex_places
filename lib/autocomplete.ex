defmodule ExPlaces.Autocomplete do
  @moduledoc """
  A Google Maps Places request
  """

  alias __MODULE__
  alias ExPlaces.ComponentFilters
  alias ExPlaces.HTTP

  defstruct input: nil, # required
    types: nil, # geocode, address or establishment
    offset: nil,
    radius: nil,
    language: nil,
    components: nil

  @type t :: %__MODULE__{}

  def places_autocomplete(%Autocomplete{} = request) do
    request
    |> Map.from_struct
    |> HTTP.attach_api_key
    |> Enum.filter(fn {_, v} -> v != nil end) #remove nil values
    |> HTTP.get("/autocomplete/json")
  end

  def places_autocomplete(input) when is_bitstring(input) do
    %Autocomplete{input: input}
    |> places_autocomplete
  end

  def places_autocomplete(input, %ComponentFilters{} = components) do
    %Autocomplete{input: input, components: ComponentFilters.serialize(components)}
    |> places_autocomplete
  end

end

