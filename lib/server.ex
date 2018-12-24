defmodule Helloworld.Greeter.Server do
  use GRPC.Server, service: Helloworld.Greeter.Service

  @spec say_hello(Helloworld.HelloRequest.t(), GRPC.Server.Stream.t()) ::
          Helloworld.HelloReply.t()
  def say_hello(request, _stream) do
    Helloworld.HelloReply.new(message: "Hello #{request.name}")
  end

  def say_repeat_hello(req, stream) do
    (1..req.count)
    |> Enum.each(fn i ->
      reply = Helloworld.HelloReply.new(message: "Hey! #{req.name}")
      GRPC.Server.send_reply(stream, reply)
      Process.sleep(500)
    end)
  end

  def say_hello_after_delay(req, _stream) do
    Process.sleep(5000)
    Helloworld.HelloReply.new(message: "Hello! #{req.name}")
  end
end
