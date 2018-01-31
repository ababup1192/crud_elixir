defmodule Crud.Store do
  use GenServer

  def start_link(), do: start_link(0)

  def start_link(init_num) do
    GenServer.start_link(__MODULE__, %{last_message: "初期状態", count: init_num}, name: __MODULE__)
  end

  def get_state do
    GenServer.call(__MODULE__, :get_state)
  end

  def inc do
    GenServer.cast(__MODULE__, :inc)
  end

  def kill do
    GenServer.cast(__MODULE__, :kill)
  end

  ####################
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_cast(:inc, state) do
    new_state = %{count: state.count + 1, last_message: "inc呼び出し"}
    {:noreply, new_state}
  end
end
