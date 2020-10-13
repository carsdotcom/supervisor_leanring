defmodule CounterSupervisor do
  use GenServer

  def start(initial_state) do
    IO.puts("Starting Supervisor....")
    GenServer.start(__MODULE__, initial_state, name: __MODULE__)
  end

  def init(initial_state) do
    Process.flag(:trap_exit, true)

    {:ok, start_server(initial_state)}
  end

  def handle_info({:EXIT, _pid, reason}, state) do
    IO.puts("Got EXIT with reason of: #{reason}")
    IO.inspect(state, label: "State")
    {:noreply, start_server(state)}
  end

  defp start_server(initial_state) do
    IO.puts("Starting Counter Server....")
    counter_pid = spawn_link(SimpleCounter, :run, [initial_state])
    Process.register(counter_pid, :counter_server)
    counter_pid
  end
end
