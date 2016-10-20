defmodule ExPlaces.Autocomplete do
  @moduledoc """
  """

  alias __MODULE__
  alias ExPlaces.Helper
  alias ExPlaces.Prediction
  import Poison, only: [decode: 1]

  defstruct predictions: [],
    status: nil

  @type t :: %__MODULE__{}

  @doc """
  """
  @spec parse(String.t) :: map
  def parse(autocomplete_response) do
    response =
      autocomplete_response
      |> decode
      |> atomise_keys

    Autocomplete
    |> struct(response)
    |> parse_predictions
  end

  @spec atomise_keys({atom, map}) :: map
  defp atomise_keys({:ok, response}) do
    Helper.atomise_keys(response)
  end

  @spec parse_predictions(Autocomplete.t) :: Autocomplete.t
  defp parse_predictions(%Autocomplete{predictions: predictions} = autocomplete) do
    %Autocomplete{autocomplete | predictions: Enum.map(predictions, &Prediction.parse/1)}
  end
end
