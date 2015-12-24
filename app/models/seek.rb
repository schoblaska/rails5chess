class Seek
  def self.create(uuid)
    if opponent = REDIS.spop("seeks")
      Game.start(uuid, opponent)
    else
      REDIS.sadd("seeks", uuid)
    end
  end

  def self.remove(uuid)
    REDIS.srem("seeks", uuid)
  end
end
