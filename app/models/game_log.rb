class GameLog
  attr_reader(:game_log)
  def initialize(log=[])
    @game_log = log
  end

  def get_log
    game_log[0..9]
  end

  def add_log(type, player, target=nil, rank)
    if type == 'pair'
      @game_log.unshift("#{player.name} paired 4 #{rank}s")
    elsif type == 'take'
      @game_log.unshift("#{player.name} took all #{rank}s from #{target.name}")
    elsif type == 'fish'
      @game_log.unshift("#{player.name} asked #{target.name} for a #{rank} but went fishing")
    end
  end
end
