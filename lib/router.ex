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

  get "/persons" do
    params = Repository.as_entity_list()
    send_resp(conn, 200, Poison.encode!(params))
  end

  # {name: "John", job: "SE"}
  post "/persons" do
    Repository.store(conn.body_params)
    send_resp(conn, 201, "")
  end

  # {id: 1, name: "Mike", job: "WD"}
  put "/persons" do
    Repository.update(conn.body_params)
    send_resp(conn, 200, "")
  end

  delete "/persons/:id" do
    Repository.delete(String.to_integer(id))
    send_resp(conn, 200, "")
  end

  match(_, do: send_resp(conn, 404, "Not Found!"))
end
