use Mix.Config

config :ex_places,
  api_host: "https://maps.googleapis.com"

import_config "#{Mix.env}.exs"
