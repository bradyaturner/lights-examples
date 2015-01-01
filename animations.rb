#!/usr/bin/env ruby

require 'lights'

LIGHTS_CONFIG_PATH = "#{ENV["HOME"]}/.lightsconfig"
DEFAULT_DELAY = 5

@config = {}
if File.exists? LIGHTS_CONFIG_PATH
  @config = JSON.parse( IO.read( LIGHTS_CONFIG_PATH ) )
end

hue = Lights.new @config["bridge_ip"], @config["username"]

delay = ARGV[0] ? ARGV[0].to_i : DEFAULT_DELAY

b = BulbState.new
b.sat = BulbState::MAX_SAT
b.bri = BulbState::MAX_BRI
b.transition_time = delay*10

puts "Press ctrl+c to stop."

while TRUE
  BulbState::Hue.constants.each do |c|
    b.hue = BulbState::Hue.const_get c
    hue.set_group_state(0,b)
    sleep delay
  end
end

