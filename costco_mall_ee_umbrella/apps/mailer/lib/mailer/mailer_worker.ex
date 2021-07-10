defmodule Mailer.MailerWorker do
  use GenServer

  # Callbacks

  @impl true
  def init(stack) do
    # Initial state
    IO.inspect(stack)
    {:ok, stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end
end
