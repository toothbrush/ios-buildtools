#
# Rakefile which finds the .xcodeproj/ directory and passes
# it off to the xcodebuild commandline tool.
#
# Place this file in a parent directory of the one containing your
# .xcodeproj.
#
# Borrowed from http://blog.highorderbit.com/2009/09/02/building-xcode-projects-in-vim-with-rake/
#
# Modified slightly by Paul van der Walt, 2011

require 'find'

def project_file(root_dir='.')
  Find.find(root_dir) do |f|
    if f =~ /\.xcodeproj$/
      return f
    end
  end
  nil
end

def xcodebuild
    puts ENV['PATH']
    "xcodebuild-wrapper.sh #{project_file}"
end

desc 'Build the default target using the default configuration'
task :build do |t|
  puts %x{
    #{xcodebuild} |
    grep -v "note: This view overlaps one of its siblings ."
  }
end

task :default => [ :build ]
