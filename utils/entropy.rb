#!/usr/bin/env ruby

class String
  def entropy
    self.each_char.group_by(&:to_s).values.map { |x| x.length / self.length.to_f }.reduce(0) { |e, x| e - x*Math.log2(x) }
  end
end

if __FILE__ == $0
  puts ARGV[0].entropy
end

