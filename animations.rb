#!/usr/bin/env ruby

require 'lights'

LIGHTS_CONFIG_PATH = "#{ENV["HOME"]}/.lightsconfig"

YELLOW = 12750
LGREEN = 22500
GREEN = 25500
BLUE = 46920
PURPLE = 56100
RED = 65535

DEFAULT_DELAY = 5

@config = {}
if File.exists? LIGHTS_CONFIG_PATH
  @config = JSON.parse( IO.read( LIGHTS_CONFIG_PATH ) )
end
hue = Lights.new @config["bridge_ip"], @config["username"]

delay = ARGV[0] ? ARGV[0].to_i : DEFAULT_DELAY

b = BulbState.new
b.transition_time = delay*10
b.sat = BulbState::MAX_SAT

colors = [ YELLOW, LGREEN, GREEN,
            BLUE, PURPLE, RED ]

while TRUE
  colors.each do |c|
    b.hue = c
    hue.set_group_state(0,b)
    sleep delay
  end
end

