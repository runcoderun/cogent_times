def runcoderun?
  ENV["RUN_CODE_RUN"]
end

if runcoderun?
  task :default => [';gems:build',':rcov:all']
else
  task :default => :test
end