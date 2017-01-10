defmodule ExPlaces.Place do

  @moduledoc false # TODO

  alias __MODULE__
  alias ExPlaces.HTTP

  defstruct placeid: nil

  @type t :: %__MODULE__{}

  def get_by_id(%Place{} = request) do
    request
    |> Map.from_struct
    |> HTTP.attach_api_key
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> HTTP.get("/details/json")
  end

  def get_by_id(place_id) when is_bitstring(place_id) do
    %Place{placeid: place_id}
    |> get_by_id
  end

end
