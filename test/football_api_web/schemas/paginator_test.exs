defmodule FootballApiWeb.Schemas.PaginatorTest do
  use ExUnit.Case, async: true
  alias FootballApiWeb.Schemas.Paginator

  describe "validate_params/1" do
    setup do
      valid_params = [%{page_number: 1, page_size: 2}, %{}, %{page_number: 1}]
      invalid_params = [%{page_number: "a"}]

      %{valid_params: valid_params, invalid_params: invalid_params}
    end

    test "return ok with valid schema when parameters are valid", %{valid_params: valid_params} do
      valid_params
      |> Enum.each(fn param ->
        assert {:ok, %Scrivener.Config{page_number: _, page_size: _}} =
                 Paginator.validate_params(param)
      end)
    end

    test "uses default config if parameter is not defined" do
      no_size_param = %{page_number: 3}
      no_number_param = %{page_size: 2}

      assert {:ok, %Scrivener.Config{page_number: 3, page_size: 10}} =
               Paginator.validate_params(no_size_param)

      assert {:ok, %Scrivener.Config{page_number: 1, page_size: 2}} =
               Paginator.validate_params(no_number_param)
    end

    test "return KO with valid schema when parameters are valid", %{
      invalid_params: invalid_params
    } do
      invalid_params
      |> Enum.each(fn param ->
        assert {:error, :bad_request} = Paginator.validate_params(param)
      end)
    end
  end

  describe "paginate/2" do
    setup do
      list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
      config = %Scrivener.Config{page_number: 3, page_size: 2}
      %{list: list, config: config}
    end

    test "paginates with given config", %{list: list, config: config} do
      assert %Scrivener.Page{
               entries: [5, 6],
               page_number: 3,
               page_size: 2,
               total_entries: 10,
               total_pages: 5
             } = Paginator.paginate(list, config)
    end
  end
end
