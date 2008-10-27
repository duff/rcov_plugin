def run_coverage(files)
  rm_f "coverage"
  rm_f "coverage.data"
  
  # turn the files we want to run into a  string
  if files.length == 0
    puts "No files were specified for testing"
    return
  end
  
  files = files.join(" ")
  
  if PLATFORM =~ /darwin/
    exclude = '--exclude "gems/*"'
  else
    exclude = '--exclude "rubygems/*"'
  end
  
  rcov = "rcov --rails -Ilib:test --sort coverage --text-report #{exclude} --no-validator-links"
  cmd = "#{rcov} #{files}"
  sh cmd
  system("open coverage/index.html") if PLATFORM['darwin']
end

namespace :test do
  
  desc "Measures unit, functional, and integration test coverage"
  task :coverage do
    run_coverage Dir["test/**/*.rb"]
  end
  
end