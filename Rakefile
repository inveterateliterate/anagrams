require "sinatra/activerecord/rake"
require 'rspec/core/rake_task'

namespace :db do
  task :load_config do
    require "./app"
  end  
end

desc 'Start IRB with application environment loaded'
task "console" do
  exec "irb -r ./app"
end

desc "Run the specs"
task 'specs' do
  exec "rspec spec"
end

def alias_task(tasks)
  tasks.each do |new_name, old_name|
    task new_name, [*Rake.application[old_name].arg_names] => [old_name]
  end
end

alias_task [
  ["generate:migration","db:create_migration"]
]