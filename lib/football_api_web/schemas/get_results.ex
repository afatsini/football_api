defmodule FootballApi.Schemas.GetResults do
  @moduledoc """
    Parameter filter for get results action.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias __MODULE__

  @allowed_fields ~w(div season)a
  @required_fields ~w()a

  embedded_schema do
    field(:div, :string)
    field(:season, :string)
  end

  def validate_params(params) do
    changeset = changeset(params)

    case changeset.valid? do
      true -> {:ok, apply_changes(changeset)}
      false -> {:error, {:bad_request, traverse_errors(changeset, & &1)}}
    end
  end

  defp changeset(params) do
    %GetResults{}
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
  end
end
