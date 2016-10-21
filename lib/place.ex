defmodule ExPlaces.Place do
  @moduledoc """
  """

  alias __MODULE__
  alias ExPlaces.Helper

  import Poison, only: [decode: 1]

  defstruct placeid: nil

  @type t :: %__MODULE__{}

end
