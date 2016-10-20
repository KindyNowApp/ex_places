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

  def start(_,_) do
    import Supervisor.Spec, warn: false

    children = []

    opts = [strategy: :one_for_one, name: ExPlaces.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @spec places_autocomplete(String.t) :: {atom, map}
  def places_autocomplete(input) do
    Request.places_autocomplete(input)
  end

  def place_by_id(place_id) do
    Request.place_by_id(place_id)
  end
end
