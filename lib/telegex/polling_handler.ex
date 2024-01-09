defmodule Ieltsin.Telegex.PollingHandler do
  use Telegex.Polling.GenHandler

  @impl true
  def on_boot() do
    {:ok, true} = Telegex.delete_webhook()
    %Telegex.Polling.Config{}
  end

  def on_update(%{message: %Telegex.Type.Message{} = message}) do
    require Logger
    Logger.info("on_update: message: #{inspect(message)}")
  end

  @impl true
  def on_update(%Telegex.Type.Update{} = update) do
    require Logger
    Logger.info("on_update: unknown update: #{inspect(update)}")
  end
end
