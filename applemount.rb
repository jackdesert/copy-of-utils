#! /usr/bin/ruby

# Use this file to automate mounting of your apple file protocol shares
# First verify that you can connect. 
# Hint: http://wiki.jackdesert.com/Linux/apple_file_protocol

require 'pathname'
require 'pry-debugger'

USERNAME = 'jack'
PASSWORD_FILE = '/home/jd/.jms_password'
SERVER = '10.1.10.10'
MOUNT_POINT_BASE = "/home/jd/afp"
AVAILABLE_VOLUMES = ['Creative',
                    'Photography',
                    'PM',
                    'Resources',
                    'Technology',
                    'Innovations',
                    'Motion']


def create_dir(dir)
  Dir.mkdir(dir) unless Dir.exist?(dir)
end

password = (`cat #{PASSWORD_FILE}`).strip
volume = ARGV[0]
raise 'no volume given' if volume.nil?
volume = volume.clone.capitalize

raise "volume '#{volume}' not included in #{AVAILABLE_VOLUMES.to_s}" unless AVAILABLE_VOLUMES.include? volume

mount_point = Pathname.new(MOUNT_POINT_BASE) + volume

create_dir(MOUNT_POINT_BASE)
create_dir(mount_point)

command = "afp_client mount -u #{USERNAME} -p #{password} #{SERVER}:#{volume} #{mount_point}"
puts command.gsub(password, 'your_secret_password')
# Execute command
puts 'Connecting...'
system(command)

