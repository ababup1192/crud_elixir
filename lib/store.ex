defmodule Crud.Repository do
  use GenServer

  def start_link() do
    :mnesia.start()
    :mnesia.create_table(Person, attributes: [:id, :name, :job])
    GenServer.start_link(__MODULE__, %{id: 1}, name: __MODULE__)
  end

  def as_entity_list() do
    GenServer.call(__MODULE__, :as_entity_list)
  end

  def store(person) do
    GenServer.cast(__MODULE__, {:store, person})
  end

  def update(person) do
    GenServer.cast(__MODULE__, {:update, person})
  end

  def delete(id) do
    GenServer.cast(__MODULE__, {:delete, id})
  end

  def kill do
    GenServer.cast(__MODULE__, :kill)
  end

  ####################
  def handle_call(:as_entity_list, _from, state) do
    persons = :mnesia.dirty_match_object({Person, :_, :_, :_})

    persons_map =
      Enum.map(persons, fn {Person, id, name, job} -> %{id: id, name: name, job: job} end)

    {:reply, persons_map, state}
  end

  def handle_cast({:store, person}, state) do
    :mnesia.dirty_write({Person, state.id, person["name"], person["job"]})

    {:noreply, %{id: state.id + 1}}
  end

  def handle_cast({:update, person}, state) do
    :mnesia.dirty_write({Person, person["id"], person["name"], person["job"]})

    {:noreply, state}
  end

  def handle_cast({:delete, id}, state) do
    :mnesia.dirty_delete({Person, id})

    {:noreply, state}
  end
end
