defmodule Ieltsin.Application do
  use Application

  def start(_, _) do
    children = [repo(), polling_handler()]
    opts = [strategy: :one_for_one, name: Ieltsin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp repo do
    Ieltsin.Repo
  end

  defp polling_handler do
    Ieltsin.Telegex.PollingHandler
  end
end
