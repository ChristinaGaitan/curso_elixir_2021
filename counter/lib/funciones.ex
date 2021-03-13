sync_query = fn(query_def) ->
  :timer.sleep(2000)
  "#{query_def} result"
end

async_query = fn(query_def) ->
  spawn(fn -> IO.puts(sync_query.(query_def)) end)
end

async_query = fn(query_def) ->
  # Este código se ejecuta en el proceso del shell
  caller = self() # es una función que devuelve el id del proceso en donde se ejecuta el código

  # El cóido dentro del spawn es el código que se ejecuta en el nuevo proceso
  spawn(fn ->
    send(caller, {:query_result, sync_query.(query_def)})
   end)
end

get_result = fn ->
  receive do
    {:query_result, result} -> result
  end
end

1..5 |>
 Enum.map(&async_query.("query #{&1}")) |>
 Enum.map(fn(_) -> get_result.() end)

# ===============================
async_queries = fn(queries) ->
  queries |>
  Enum.map(&async_query.("query #{&1}")) |>
  Enum.map(fn(_) -> get_result.() end)
end

defmodule DatabaseServer do
  def start do
    # crea el proceso que esta representando al servidor
    # loop se ejecuta en un segundo proceso
    spawn(&loop/0)
  end

  defp loop do
    receive do
      {:run_query, caller, query_def} ->
        send(caller, {:query_result, sync_query(query_def)})
    end
    loop()
  end

  defp sync_query(query_def) do
    :timer.sleep(2000)
    "#{query_def} result"
  end

  def send_query(query) do
    # DatabaseServer.send_query("Query 1")
  end

  def get_result do
  end
end

defmodule DatabaseServer do
  def start do
    spawn(&loop/0)
  end

  defp loop do
    receive do
      {:run_query, caller, query_def} ->
        send(caller, {:query_result, sync_query(query_def)})
    end
    loop()
  end

  defp sync_query(query_def) do
    :timer.sleep(2000)
    "#{query_def} result"
  end

  def send_query(server_pid, query) do
    send(server_pid, {:run_query, self(), query})
  end

  def get_result do
    receive do
      {:query_result, result} -> result
    after 5000 ->
      {:error, :timeout}
    end
  end
end

pool =
  1..100 |>
    Enum.map(fn(_) -> DatabaseServer.start end)

1..50 |>
  Enum.each(fn(query_def) ->
    server_pid = Enum.at(pool, :random.uniform(100) - 1)
    DatabaseServer.send_query(server_pid, query_def)
  end)
