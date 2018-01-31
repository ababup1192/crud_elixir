defmodule Crud.Repository do
  use GenServer

  def start_link(), do: start_link(0)

  def start_link(init_num) do
    table = :ets.new(:temp_table, [:set, :public])
    :ets.insert(table, {:users, []})
    GenServer.start_link(__MODULE__, %{table: table}, name: __MODULE__)
  end

  def as_entity_list() do
    GenServer.call(__MODULE__, :as_entity_list)
  end

  def store(user) do
    GenServer.cast(__MODULE__, {:store, user})
  end

  def kill do
    GenServer.cast(__MODULE__, :kill)
  end

  ####################
  def handle_call(:as_entity_list, _from, state) do
    {:reply, to_users_map(:ets.lookup(state.table, :users)[:users]), state}
  end

  def handle_cast({:store, user}, state) do
    users = :ets.lookup(state.table, :users)[:users]
    :ets.insert(state.table, {:users, users ++ [user]})
    {:noreply, state}
  end

  def to_users_map(users), do: %{"users": users}
end
