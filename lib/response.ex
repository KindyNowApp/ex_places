defmodule ExPlaces.AutocompleteResponse do
  @moduledoc """
  """

  alias __MODULE__
  alias ExPlaces.Helper


  defstruct predictions: [],
    status: nil

  import Poison, only: [decode: 1]

  @type t :: %__MODULE__{}

  @doc """
  """
  @spec parse(String.t) :: map
  def parse(json) do
    response = json
      |> decode
      |> atomise_keys
  end

  defp atomise_keys({:ok, response}) do
    Helper.atomise_keys(response)
  end
end
