class Timer
   attr_writer :seconds
  def initialize(seconds=0)
    @seconds = seconds
  end
  def seconds
    time_string
    return @seconds
  end
  def time_string
    seconds = @seconds % 60
    minutes = (@seconds - seconds)% 3600 / 60
    hours = (@seconds - minutes - seconds)/3600
    seconds_str = seconds.to_s
    seconds_double = seconds_str.length == 2 ? seconds_str : '0' + seconds_str
    minutes_str = minutes.to_s
    minutes_double = minutes_str.length == 2 ? minutes_str : '0' + minutes_str
    hours_str = hours.to_s
    hours_double = hours_str.length == 2 ? hours_str : '0' + hours_str
    return hours_double + ":" + minutes_double + ":" + seconds_double
  end
end
