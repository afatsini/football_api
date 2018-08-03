defmodule FootballApiWeb.Schemas.GetMatchesTest do
  use ExUnit.Case, async: true
  alias FootballApiWeb.Schemas.GetMatches

  setup do
    valid_params = [%{div: "SP1", season: "201516"}, %{}, %{div: "SP2"}]

    invalid_params = [%{div: 999}]

    %{valid_params: valid_params, invalid_params: invalid_params}
  end

  describe "validate_params/1" do
    test "return ok with valid schema when parameters are valid", %{valid_params: valid_params} do
      valid_params
      |> Enum.each(fn param ->
        assert {:ok, %{div: _, season: _}} = GetMatches.validate_params(param)
      end)
    end

    test "return KO with valid schema when parameters are valid", %{
      invalid_params: invalid_params
    } do
      invalid_params
      |> Enum.each(fn param ->
        assert {:error, {:bad_request, _}} = GetMatches.validate_params(param)
      end)
    end
  end
end
