defmodule Ieltsin.Application do
  use Application

  def start(_, _) do
    children = [repo()]
    opts = [strategy: :one_for_one, name: Ieltsin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp repo do
    Ieltsin.Repo
  end
end
