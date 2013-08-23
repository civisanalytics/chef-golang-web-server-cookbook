include_attribute "nutty::configure"

node[:deploy].each do |application, _|
  default[:nutty][application][:service_realm] = node[:service_realm]
  
  if node[:deploy][application][:environment] && node[:deploy][application][:environment]["HOME"] && node[:deploy][application][:env]
    default[:nutty][application][:env] = {"HOME" => node[:deploy][application][:environment]["HOME"]}.merge(node[:deploy][application][:env])
  elsif node[:deploy][application][:environment] && node[:deploy][application][:environment]["HOME"]
    default[:nutty][application][:env] = {"HOME" => node[:deploy][application][:environment]["HOME"]}
  elsif node[:deploy][application][:env]
    default[:nutty][application][:env] = node[:deploy][application][:env]
  end
  
  default[:nutty][application][:restart_server_command] = "monit restart nutty_#{application}_server"
  default[:nutty][application][:stop_server_command] = "monit stop nutty_#{application}_server"
  
  default[:nutty][application][:config_file] = "#{node[:deploy][application][:deploy_to]}/shared/config/nutty.properties"
  default[:nutty][application][:pid_file] = "#{node[:deploy][application][:deploy_to]}/shared/pids/nutty.pid"
  default[:nutty][application][:output_file] = "#{node[:deploy][application][:deploy_to]}/shared/log/nutty.log"
end