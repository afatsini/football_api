defmodule FootballApiWeb.Schemas.Paginator do
  @moduledoc """
    Parameter filter for pagination
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias __MODULE__

  @allowed_fields ~w(page_number page_size)a
  @required_fields ~w()a

  embedded_schema do
    field(:page_number, :integer)
    field(:page_size, :integer)
  end

  def validate_params(params) do
    changeset = changeset(params)

    case changeset.valid? do
      true -> {:ok, build_config(changeset)}
      false -> {:error, :bad_request}
    end
  end

  def paginate(list, config) do
    Scrivener.paginate(list, config)
  end

  defp changeset(params) do
    %Paginator{}
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
  end

  defp build_config(changeset) do
    params = apply_changes(changeset)
    default_config(params)
  end

  defp default_config(%{page_number: page_number, page_size: page_size}) do
    %Scrivener.Config{page_number: page_number || 1, page_size: page_size || 10}
  end
end
