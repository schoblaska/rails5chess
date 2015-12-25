# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player_#{uuid}"
    Seek.create(uuid)
  end

  def unsubscribed
    Seek.remove(uuid)
    Game.forfeit(uuid)
  end

  def make_move(data)
    Game.make_move(uuid, data)
  end
end
