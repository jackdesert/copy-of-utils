#! /usr/env/ruby
# This is a script to offer shortcuts to navigate around a Rails app
# Set up an alias like this in your ~/.bashrc:
#   alias c='cd $(ruby /path/to/nav.rb c)'
#   alias m='cd $(ruby /path/to/nav.rb m)'
#   alias v='cd $(ruby /path/to/nav.rb v)'

class Nav
  PATHS = {c: 'app/controllers',
           m: 'app/models',
           v: 'app/views'}

  def initialize(token)
    @desired_path = get_path_from_token(token)
  end

  def print_new_path
    take_me_there
    puts Dir.pwd
  end

  protected

  def take_me_there
    take_me_home
    Dir.chdir @desired_path
  end

  def take_me_home
    while not gemfile_found?
      up_one_dir
    end
  end

  def up_one_dir
    Dir.chdir '..'
  end

  def gemfile_found?
    File.exist? 'Gemfile'
  end

  def get_path_from_token(token)
    path = PATHS[token.to_sym]
    raise 'no path found' unless path
    path
  end


end

token = ARGV[0]
raise 'no token found' unless token
my_nav = Nav.new(token)
my_nav.print_new_path
