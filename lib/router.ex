defmodule Crud.Router do
  use Plug.Router
  alias Crud.Store, as: Store

  plug(:match)

  plug(
    Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug(:dispatch)

  get "/" do
    Store.inc
    params = Store.get_state
    IO.inspect params
    # IO.inspect :ets.lookup(table(), :name)
    send_resp(conn, 200, "hello")
  end

  post "/" do
    # :ets.insert(table(), {:name, conn.body_params["name"]})
    send_resp(conn, 200, Poison.encode!(conn.body_params))
  end
end
