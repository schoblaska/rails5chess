class Game
  def self.start(uuid1, uuid2)
    white, black = [uuid1, uuid2].shuffle

    ActionCable.server.broadcast "player_#{white}", "You play white"
    ActionCable.server.broadcast "player_#{black}", "You play black"

    REDIS.set("opponent_for:#{white}", black)
    REDIS.set("opponent_for:#{black}", white)
  end

  def self.forfeit(uuid)
    winner = opponent_for(uuid)
    ActionCable.server.broadcast "player_#{winner}", "Opponent forfeits. You win!"
  end

  def self.opponent_for(uuid)
    REDIS.get("opponent_for:#{uuid}")
  end
end
