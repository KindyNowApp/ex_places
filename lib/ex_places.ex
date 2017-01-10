defmodule ExPlaces do

  @moduledoc """
  An Elixir API client for the Google Maps Places API

  ## Usage

  ```
  def deps
    [{:ex_places, "~> 0.1"}]
  ```

  Add the `:ex_places` application as your list of applications in `mix.exs`:

  ```elixir
  def applications do
    [applications: [:logger, :ex_places]]
  end
  ```
  """

  use Application
  alias ExPlaces.ComponentFilters
  alias ExPlaces.Autocomplete
  alias ExPlaces.Place

  def start(_,_) do
    import Supervisor.Spec, warn: false

    children = []

    opts = [strategy: :one_for_one, name: ExPlaces.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @spec places_autocomplete(String.t) :: {atom, map}
  def places_autocomplete(input) do
    Autocomplete.places_autocomplete(input)
  end

  @spec places_autocomplete(String.t, ComponentFilters.t) :: {atom, map}
  def places_autocomplete(input, component_filters) do
    Autocomplete.places_autocomplete(input, component_filters)
  end

  def place_by_id(place_id) do
    Place.get_by_id(place_id)
  end

end
