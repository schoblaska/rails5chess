# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player_#{uuid}"
    find_game
  end

  def unsubscribed
    redis.srem("seeks", uuid)
    # forfeit game
  end

  private

  def find_game
    if opponent = redis.spop("seeks")
      white, black = [uuid, opponent].shuffle
      ActionCable.server.broadcast "player_#{white}", "You play white"
      ActionCable.server.broadcast "player_#{black}", "You play black"
    else
      redis.sadd("seeks", uuid)
    end
  end

  def redis
    @redis ||= Redis.new(ActionCable.server.config.redis)
  end
end
