defmodule Ieltsin.Telegex.PollingHandler do
  alias Ieltsin.Domain.Progresses
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
  def on_update(%{callback_query: %{data: "+15;" <> user_id} = q}) do
    {:ok, progress} = user_id |> Progresses.increase()
    progress |> update_message(q, user_id)
  end

  @impl true
  def on_update(%{callback_query: %{data: "-15;" <> user_id} = q}) do
    {:ok, progress} = user_id |> Progresses.reduce()
    progress |> update_message(q, user_id)
  end

  @impl true
  def on_update(%Telegex.Type.Update{} = update) do
    Logger.info("on_update: unknown update: #{inspect(update)}")
  end

  defp handle_message(nil, message) do
    {:ok, %{user: user}} = message.from.id |> Users.create()
    handle_message(user, message)
  end

  defp handle_message(user, message) do
    user.id |> Progresses.get_by_user_id() |> handle_message(user, message)
  end

  defp handle_message(nil, _user, _message) do
    Logger.error("progress is nil for some reason")
  end

  defp handle_message(progress, _user, %{chat: %{id: chat_id}}) do
    {:ok, _message} =
      Telegex.send_message(
        chat_id,
        progress |> create_message(),
        reply_markup: progress.user_id |> build_reply_markup()
      )
  end

  defp build_reply_markup(user_id) do
    %Telegex.Type.InlineKeyboardMarkup{
      inline_keyboard: [
        [
          %Telegex.Type.InlineKeyboardButton{text: "+15 minutes", callback_data: "+15;#{user_id}"}
        ],
        [%Telegex.Type.InlineKeyboardButton{text: "-15 minutes", callback_data: "-15;#{user_id}"}]
      ]
    }
  end

  defp create_message(%{quarters_left: quarters}) do
    hours = div(quarters, 4)
    minutes = rem(quarters, 4) * 15
    "You have to train your English for #{hours} hours and #{minutes} minutes more"
  end

  defp update_message(progress, q, user_id) do
    progress
    |> create_message()
    |> Telegex.edit_message_text(
      message_id: q.message.message_id,
      chat_id: q.message.chat.id,
      reply_markup: build_reply_markup(user_id)
    )
  end
end
