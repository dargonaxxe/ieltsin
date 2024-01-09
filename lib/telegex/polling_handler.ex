defmodule Ieltsin.Telegex.PollingHandler do
  alias Ieltsin.Domain.Users
  use Telegex.Polling.GenHandler
  require Logger

  @impl true
  def on_boot() do
    {:ok, true} = Telegex.delete_webhook()
    %Telegex.Polling.Config{}
  end

  @impl true
  def on_update(%{message: %Telegex.Type.Message{} = message}) do
    Logger.info("on_update: message: #{inspect(message)}")
    message.from.id |> Users.get_by_tg_id() |> handle_message(message)
  end

  @impl true
  def on_update(%Telegex.Type.Update{} = update) do
    Logger.info("on_update: unknown update: #{inspect(update)}")
  end

  defp handle_message(nil, message) do
    {:ok, user} = message.from.id |> Users.create()
    handle_message(user, message)
  end

  defp handle_message(_, message) do
    Logger.info("handle_message: #{inspect(message)}")
  end
end
