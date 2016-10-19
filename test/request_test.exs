defmodule ExPlaces.RequestTest do
  use ExUnit.Case, async: true

  alias ExPlaces.Request

  setup do
    bypass = Bypass.open
    Application.put_env :ex_places, :api_host, "http://localhost:#{bypass.port}"

    {:ok, %{ bypass: bypass } }
  end

  test "Autocomplete place", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      assert "/maps/api/place/autocomplete/json" == conn.request_path
      assert %{ "key" => "" } == URI.decode_query(conn.query_string)
      assert "GET" == conn.method

      Plug.Conn.resp(conn, 200, "")
    end

    assert {:ok, _response} = Request.places_autocomplete("")
  end
end
