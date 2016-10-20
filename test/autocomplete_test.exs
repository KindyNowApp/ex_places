defmodule ExPlaces.AutocompleteTest do
  use ExUnit.Case, async: true

  alias ExPlaces.Autocomplete
  alias ExPlaces.Prediction

  setup do
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

    {:ok, %{ valid_response: valid_response } }
  end

  @tag :only
  test "Parse autocomplete respones", %{
    valid_response: valid_response 
  } do
    parsed = %Autocomplete{
      predictions: [
        %Prediction{
          description: "Richmond, Victoria, 3121, Australia"
        }
      ],
      status: "OK"
    }
    assert parsed == Autocomplete.parse(valid_response)
  end
end
