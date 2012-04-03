require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  link_dotfiles
  backup_and_execute_osx_prefs
  puts green("Success! Be sure to restart terminal or run `source ~/.bash_profile`")
end

def link_dotfiles
  replace_all = false
  Dir['home/**/*'].each do |file|
    target = target_for(file)

    # TODO: Just symlink root directory instead of symlinking each individual file
    # if directory doesn't exist in HOME
    if File.directory?(file)
      unless File.exists?(target)
        puts "Making directory #{target}"
        Dir.mkdir(target)
      end
      next
    end

    if File.exist?(target)
      if File.identical? file, target
        puts "identical #{target}"
      elsif replace_all
        replace_file(file)
      else
        print yellow("overwrite #{target}? [ynaq] ")
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping #{target}"
        end
      end
    else
      link_file(file)
    end
  end
end

def target_for(file)
  file.sub(/^home/, ENV['HOME']).sub('_.', '.').sub('.erb', '')
end

def replace_file(file)
  target = target_for(file)
  system %Q{rm -rf "#{target}"}
  link_file(file)
end

def link_file(file)
  target = target_for(file)
  if file =~ /.erb$/
    puts cyan("generating #{target} from #{file}")
    File.open(target, 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts cyan("linking #{file} => #{target}")
    system %Q{ln -s "$PWD/#{file}" "#{target}"}
  end
end

def backup_and_execute_osx_prefs
  print yellow("backup and write osx prefs? [yn] ")
  if $stdin.gets.chomp == 'y'
    backup = "~/preferences-#{Time.now.strftime('%Y%m%d-%H%M%S')}.tgz"
    puts "backing up prefs to #{backup} (sudo needed to copy plist preference files)"
    %x(sudo tar -pzcf #{backup} ~/Library/Preferences /Library/Preferences)
    puts cyan("writing and reloading osx prefs")
    %x(sh #{File.dirname(__FILE__)}/osx.sh)
  else
    puts "skipping osx prefs"
  end
end

def yellow(str)
  "\e[33m#{str}\e[0m"
end

def cyan(str)
  "\e[36m#{str}\e[0m"
end

def green(str)
  "\e[32m#{str}\e[0m"
end
