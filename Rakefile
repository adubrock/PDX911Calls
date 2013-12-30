# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require './app/models/call.rb'

PDX911Calls::Application.load_tasks

task :fetch_calls => :environment do
  Call.import_from_xml_uri("http://www.portlandonline.com/scripts/911incidents.cfm")
end
