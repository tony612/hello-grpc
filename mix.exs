defmodule Helloworld.Mixfile do
  use Mix.Project

  def project do
    [
      app: :helloworld,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      releases: releases(),
      deps: deps()
    ]
  end

  def application do
    [mod: {HelloworldApp, []}, applications: [:logger, :grpc]]
  end

  defp releases do
    [
      helloworld: [
        applications: [
          runtime_tools: :permanent,
          helloworld: :permanent
        ],
        steps: [:assemble, :tar]
      ]
    ]
  end

  defp deps do
    [
      {:grpc, github: "tony612/grpc-elixir"},
      {:cowlib, "~> 2.8.0", hex: :grpc_cowlib, override: true},
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false}
    ]
  end
end
