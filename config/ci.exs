use Mix.Config

config :ex_places
  api_key: System.get_env("GOOGLE_MAPS_GEOCODE_API_KEY")
