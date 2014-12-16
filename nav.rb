#! /usr/env/ruby
# Nav
# This class is useful for shell navigation within a Rails application
# It will navigate up the directory tree until it finds a Gemfile.
# Then it will cd to the appropriate directory
#
# SETUP
#
# Save this file (nav.rb) somewhere on your hard drive
#
# add to your ~/.bashrc the following:
#   alias c='cd $(ruby /path/to/nav.rb c)'
#   alias m='cd $(ruby /path/to/nav.rb m)'
#   alias v='cd $(ruby /path/to/nav.rb v)'
#   alias j='cd $(ruby /path/to/nav.rb j)'
#   alias s='cd $(ruby /path/to/nav.rb s)'
#   alias r='cd $(ruby /path/to/nav.rb r)'
#
# then run
#   source ~/.bashrc
#
# Then from anywhere in your Rails directory, you can simply type:
#   c
#
# and you will be taken to RAILS_ROOT/app/controllers

class Nav
  PATHS = {c: 'app/controllers',
           m: 'app/models',
           v: 'app/views',
           j: 'app/assets/javascripts',
           s: 'app/assets/stylesheets',
           r: ''}

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
    Dir.chdir @desired_path unless @desired_path == ''
  end

  def take_me_home
    while not git_repo_found?
      up_one_dir
    end
  end

  def up_one_dir
    raise 'Reached root of filesystem, and no Gemfile found' if Dir.pwd == '/'
    Dir.chdir '..'
  end

  def git_repo_found?
    Dir.exist? '.git'
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
