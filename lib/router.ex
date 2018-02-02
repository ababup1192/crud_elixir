defmodule Crud.Router do
  use Plug.Router
  alias Crud.Repository, as: Repository

  plug(:match)

  plug(CORSPlug, origin: ["http://localhost:3000"])

  plug(
    Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug(:dispatch)

  # [ {id: 1, name: "Mike", job: "WD"}, {id: 2, name: "John", job: "PG"} ]
  get "/persons" do
    params = Repository.as_entity_list()

    send_resp(conn, 200, Poison.encode!(params)) |> halt
  end

  # {name: "John", job: "SE"}
  post "/persons" do
    Repository.store(conn.body_params)
    send_resp(conn, 201, "") |> halt
  end

  # {id: 1, name: "Mike", job: "WD"}
  put "/persons/:id" do
    Repository.update(String.to_integer(id), conn.body_params)
    send_resp(conn, 200, "") |> halt
  end

  delete "/persons/:id" do
    Repository.delete(String.to_integer(id))
    send_resp(conn, 200, "") |> halt
  end

  match(_, do: send_resp(conn, 404, "Not Found!") |> halt)
end
