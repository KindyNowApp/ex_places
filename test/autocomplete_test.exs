defmodule ExPlaces.RequestTest do
  use ExUnit.Case, async: true

  alias ExPlaces.Autocomplete

  setup do
    bypass = Bypass.open
    Application.put_env :ex_places, :api_host, "http://localhost:#{bypass.port}"

    api_key = "test_key"
    System.put_env "GOOGLE_MAPS_PLACES_API_KEY", api_key

    valid_response = """
    {
      "predictions": [
        {
          "description": "Richmond, Victoria, 3121, Australia"
        }
      ],
      "status": "OK"
    }
    """

    {:ok, %{
        api_key: api_key,
        valid_response: valid_response,
        bypass: bypass
      }
    }
  end

  @tag :only
  test "Autocomplete place", %{
    api_key: api_key,
    valid_response: valid_response,
    bypass: bypass
  } do
    Bypass.expect bypass, fn conn ->
      assert "/maps/api/place/autocomplete/json" == conn.request_path
      assert %{ "input" => "123 Test Street", "key" => api_key} == URI.decode_query(conn.query_string)
      assert "GET" == conn.method

      Plug.Conn.resp(conn, 200, valid_response)
    end

    assert {:ok, response} = ExPlaces.Autocomplete.places_autocomplete("123 Test Street")
    IO.inspect response
  end
end
