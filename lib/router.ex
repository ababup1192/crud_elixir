defmodule Crud.Router do
  use Plug.Router
  alias Crud.Repository, as: Repository

  plug(:match)

  plug(
    Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug(:dispatch)

  get "/" do
    params = Repository.as_entity_list()
    send_resp(conn, 200, Poison.encode!(params))
  end

  post "/" do
    Repository.store(2)
    # :ets.insert(table(), {:name, conn.body_params["name"]})
    send_resp(conn, 200, Poison.encode!(conn.body_params))
  end
end
