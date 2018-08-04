defmodule FootballApi.DataServer do
  @moduledoc """
    Server in charge of serving the data stored in the data csv file
  """

  use GenServer

  alias FootballApi.Schemas.Match

  @data_path Application.get_env(:football_api, FootballApi.DataServer)[:data_path]
  @table_name Application.get_env(:football_api, FootballApi.DataServer)[:table_name]

  # API
  @doc """
  Start the data server
  """
  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @doc """
  get the uniq keys of the values stored by the data server
  """
  def get_keys do
    GenServer.call(__MODULE__, :get_keys)
  end

  @doc """
  get the values based on the query provided
  """
  def get_by(query \\ []) do
    GenServer.call(__MODULE__, {:get_by, query})
  end

  # Callbacks
  def init(_) do
    initialize_ets_table()

    keys = store_matches(matches())

    {:ok, keys}
  end

  def handle_call(:get_keys, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:get_by, query}, _from, state) do
    result =
      @table_name
      |> :ets.match({{query[:div] || :_, query[:season] || :_}, :"$1"})
      |> List.flatten()

    {:reply, result, state}
  end

  defp matches do
    "#{File.cwd!()}/#{@data_path}"
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> CSV.decode!(headers: true)
    |> Enum.map(fn line ->
      line
      |> Enum.into(%{}, fn {key, value} ->
        key =
          case key do
            "" -> "id"
            key -> key
          end

        {String.to_atom(key), value}
      end)
      |> Match.new()
    end)
  end

  defp initialize_ets_table do
    :ets.new(@table_name, [:named_table, :public, :bag])
  end

  defp store_matches(matches) do
    matches
    |> Enum.map(fn match ->
      key = build_key(match)
      :ets.insert(@table_name, {key, match})
      key
    end)
    |> Enum.uniq()
  end

  defp build_key(entry) do
    div = Map.get(entry, :Div)
    season = Map.get(entry, :Season)

    {div, season}
  end
end
