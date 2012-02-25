require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['home/**/*'].each do |file|
    next if File.directory?(file)
    target = target_for(file)

    if File.exist?(target)
      if File.identical? file, target
        puts cyan("identical #{target}")
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
  puts green("Success! Be sure to restart terminal or run `source ~/.bash_profile`")
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
    puts "generating #{target} from #{file}"
    File.open(target, 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking #{file} => #{target}"
    system %Q{ln -s "$PWD/#{file}" "#{target}"}
  end
end
