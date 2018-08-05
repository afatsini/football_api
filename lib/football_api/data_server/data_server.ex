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
  get the values based on the query provided
  """
  def get_by(query \\ []) do
    GenServer.call(__MODULE__, {:get_by, query})
  end

  @doc """
  get by id
  """
  def get(id) do
    query = [id: id]
    GenServer.call(__MODULE__, {:get_by, query})
  end

  # Callbacks
  def init(_) do
    initialize_ets_table()

    store_matches(matches())

    {:ok, :success}
  end

  def handle_call({:get_by, query}, _from, state) do
    result =
      @table_name
      |> :ets.match({{query[:id] || :_, query[:div] || :_, query[:season] || :_}, :"$1"})
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
  end

  defp build_key(entry) do
    id = Map.get(entry, :id)
    div = Map.get(entry, :Div)
    season = Map.get(entry, :Season)

    {id, div, season}
  end
end
