defmodule FootballApiWeb.Schemas.GetMatches do
  @moduledoc """
    Parameter filter for get Matches action.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias __MODULE__

  @allowed_fields ~w(div season id)a
  @required_fields ~w()a

  embedded_schema do
    field(:div, :string)
    field(:season, :string)
  end

  def validate_params(params) do
    changeset = changeset(params)

    case changeset.valid? do
      true -> {:ok, apply_changes(changeset)}
      false -> {:error, :bad_request}
    end
  end

  defp changeset(params) do
    %GetMatches{}
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
  end
end
