defmodule HelloworldApp do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(GRPC.Server.Supervisor, [{Helloworld.Greeter.Server, 9090}])
    ]

    opts = [strategy: :one_for_one, name: HelloworldApp]
    Supervisor.start_link(children, opts)
  end
end
