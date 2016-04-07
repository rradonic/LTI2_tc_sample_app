namespace :init_task do
  desc "Reseed and backup all--assumes current is canonic"
  task :backup  => :environment do
    puts "cleaning db tables..."
    Lti2Tc::DeploymentRequest.delete_all
    Lti2Tc::ToolConsumerProfile.delete_all
    Lti2Tc::Resource.delete_all
    Lti2Tc::Tool.delete_all
    Lti2Tc::Link.delete_all
    GradeItem.delete_all
    GradeResult.delete_all
    Lti2Tc::ToolSetting.delete_all

    puts "load..."
    system "rake db:load"
  end

  desc "Truncate the wirelog"
  task :truncate_wirelog => :environment do
    wire_log_file = File.truncate(Rails.application.config.wire_log.output_file_name, 0)
  end
end
