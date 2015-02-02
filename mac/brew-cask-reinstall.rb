#!/usr/bin/ruby
require 'readline'
 
# create cask list
list = %x(brew cask list)
casks = list.delete!(' (!)').split("\n")
puts "\nbrew cask list\n#{casks}\n"
 
# create error cask list
err_casks = []
casks.each do |app_name|
  info = %x(brew cask info #{app_name})
  if info.include?('Not installed')
    err_casks.push(app_name)
  end
end
puts "\nerror casks\n#{err_casks}\n"
 
# remove caskroom & brew cask install
if err_casks.any?
  err_casks.each do |app_name|
    input = Readline.readline("\nreinstall #{app_name}? [y/n] ")
    if input == 'y'
      puts "remove #{app_name}"
      system "rm -rf /opt/homebrew-cask/Caskroom/#{app_name}"
      puts "install #{app_name}"
      system "brew cask install #{app_name}"
    end
  end
else
  puts '\nno error'
end
