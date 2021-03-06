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
