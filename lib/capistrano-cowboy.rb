require 'capistrano'

module Capistrano
  class Cowboy
    def self.load_into(configuration)
      configuration.load do
        namespace :cowboy do
          desc 'Deploy without SCM'
          task :default do
            deploy_stage = fetch(:stage, 'none')
            set :repository, "."
            set :deploy_via, :copy
            set :scm, :none
            set :stage, deploy_stage
            set :cowboy_deploy, true
            set :copy_exclude, [".git/*", ".svn/*", "log/*", "vendor/bundle/*"]
          end
        end
      end
    end
  end
end

if Capistrano::Configuration.instance
  Capistrano::Cowboy.load_into(Capistrano::Configuration.instance)
end
