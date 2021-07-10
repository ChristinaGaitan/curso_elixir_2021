defmodule Mailer.MailerWorker do
  use GenServer

  # Client

  def start_link(default) when is_list(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  def current() do
    GenServer.call(__MODULE__, :current)
  end

  # Server / Callbacks

  @impl true
  def init(stack) do
    # Initial state
    IO.inspect(stack)
    {:ok, stack}
  end

  @impl true
  # Parametros
  # 1. Nombre del callback
  # 2. PID del proceso que seta haciendo la llamda
  # 3. El estado actual del proceso
  def handle_call(:current, _from, state) do
    IO.inspect(self())
    Mailer.MailerOne.send()
    {:reply, state, state}
  end
  # Response:
  # 1. Eleme :reply
  # 2. Response -> estado actual
  # 3. Actualizacion del estado

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  # 1 Nombre del callback
  # 2 Estado
  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end
  # 1 :no reply
  # 2 Estado con el que queremos actualizar
end
