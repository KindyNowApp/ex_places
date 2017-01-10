defmodule ExPlaces.Prediction do

  @moduledoc false # TODO

  alias __MODULE__

  defstruct description: nil,
    id: nil,
    matched_substrings: [],
    place_id: nil,
    reference: nil,
    terms: [],
    types: []

  @type t :: %__MODULE__{}

  @spec parse(map) :: Prediction.t
  def parse(prediction_map) do
    Prediction
    |> struct(prediction_map)
  end

end
