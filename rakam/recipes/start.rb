if defined?(node['rakam-config']['ui.enable']) && node['rakam-config']['ui.enable'] == 'true'
  include_recipe 'rakam::update_ui'
end

bash "run program" do
  code <<-EOH
    su webapp -l -c '(/home/webapp/rakam-server/bin/launcher start) && (killall -9 rakam-server-heartbeat || true) && (../rakam-server-heartbeat &)'
  EOH
end
