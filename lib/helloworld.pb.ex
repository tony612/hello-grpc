defmodule Helloworld.HelloRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t()
        }
  defstruct [:name]

  field :name, 1, type: :string
end

defmodule Helloworld.RepeatHelloRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          count: integer
        }
  defstruct [:name, :count]

  field :name, 1, type: :string
  field :count, 2, type: :int32
end

defmodule Helloworld.HelloReply do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          message: String.t()
        }
  defstruct [:message]

  field :message, 1, type: :string
end

defmodule Helloworld.Greeter.Service do
  @moduledoc false
  use GRPC.Service, name: "helloworld.Greeter"

  rpc :SayHello, Helloworld.HelloRequest, Helloworld.HelloReply
  rpc :SayRepeatHello, Helloworld.RepeatHelloRequest, stream(Helloworld.HelloReply)
  rpc :SayHelloAfterDelay, Helloworld.HelloRequest, Helloworld.HelloReply
end

defmodule Helloworld.Greeter.Stub do
  @moduledoc false
  use GRPC.Stub, service: Helloworld.Greeter.Service
end
