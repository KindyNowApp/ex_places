defmodule ExPlaces.PlaceTest do
  use ExUnit.Case, async: false

  alias ExPlaces.Place

  setup do
    bypass = Bypass.open

    Application.put_env :ex_places, :api_host, "http://localhost:#{bypass.port}"

    api_key = "test_key"
    System.put_env "GOOGLE_MAPS_PLACES_API_KEY", api_key

    valid_response = """
    {
      "html_attributions": [],
      "result": {},
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

  test "Autocomplete place", %{
    api_key: api_key,
    valid_response: valid_response,
    bypass: bypass
  } do
    Bypass.expect bypass, fn conn ->
      assert "/maps/api/place/details/json" == conn.request_path
      assert %{ "placeid" => "test_id", "key" => api_key} == URI.decode_query(conn.query_string)
      assert "GET" == conn.method

      Plug.Conn.resp(conn, 200, valid_response)
    end

    assert {:ok, _} = Place.get_by_id("test_id")
  end
end
