defmodule FootballApi.DataServer do
  @moduledoc """
    Server in charge of serving the data stored in the data csv file
  """

  use GenServer

  @data_path Application.get_env(:football_api, FootballApi.DataServer)[:data_path]
  @table_name Application.get_env(:football_api, FootballApi.DataServer)[:table_name]

  # API
  @doc """
  Start the data server
  """
  def start_link() do
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

   ## Examples

      iex> GenServer.get_by(div: "SP1", season: "201617")
      [%{
       "" => "1",
       "AwayTeam" => "Eibar",
       "Date" => "19/08/16",
       "Div" => "SP1",
       "FTAG" => "1",
       "FTHG" => "2",
       "FTR" => "H",
       "HTAG" => "0",
       "HTHG" => "0",
       "HTR" => "D",
       "HomeTeam" => "La Coruna",
       "Season" => "201617"
      },
      %{...},
      %{...},
      ...]
  """
  def get_by(query \\ []) do
    GenServer.call(__MODULE__, {:get_by, query})
  end

  # Callbacks
  def init(_) do
    initialize_ets_table()

    keys = store_entries(data_hash())

    {:ok, keys}
  end

  def handle_call(:get_keys, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:get_by, query}, _from, state) do
    result =
      :ets.match(@table_name, {{query[:div] || :_, query[:season] || :_}, :"$1"})
      |> List.flatten()

    {:reply, result, state}
  end

  defp data_hash() do
    "#{File.cwd!()}/#{@data_path}"
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> CSV.decode!(headers: true)
    |> Enum.map(fn line ->
      line |> Enum.into(%{}, fn {key, value} -> {String.to_atom(key), value} end)
    end)
  end

  defp initialize_ets_table do
    :ets.new(@table_name, [:named_table, :public, :bag])
  end

  defp store_entries(entries) do
    entries
    |> Enum.map(fn entry ->
      key = build_key(entry)
      :ets.insert(@table_name, {key, entry})
      key
    end)
    |> Enum.uniq()
  end

  defp build_key(entry) do
    {entry[:Div], entry[:Season]}
  end
end
