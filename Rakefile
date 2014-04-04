#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Kibble::Application.load_tasks

#task :update_rel => :environment do
#    Tag.update_all({:rel => "|item|"}, {:rel => 'item'})
#    Tag.update_all({:rel => "|trait|"}, {:rel => 'trait'})
#    Tag.update_all({:rel => "|profession|"}, {:rel => 'profession'})
#    Tag.update_all({:rel => "|encounter|"}, {:rel => 'encounters'})
#    Tag.update_all({:rel => "|item|profession|encounter|store|"}, {:rel => 'both'})
#end
#
#task :update_category => :environment do
#    Tag.update_all({:category => "building"}, {:category => 'place'})
#end