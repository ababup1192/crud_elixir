defmodule Crud.Router do
  use Plug.Router

  # JSON のパースを行う

  plug(:match)

  plug(
    Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug(:dispatch)

  post "/" do
    IO.inspect(conn.body_params["name"])

    conn
    |> send_resp(200, conn.body_params["name"])
  end
end
