if defined?(node['rakam-config']['ui.enable']) && node['rakam-config']['ui.enable'] == 'true'
  bash "add ssh keys for ui" do
    code <<-EOH
      su webapp -l -c 'echo "#{node['rakam-ui-ssh-key']}" | tr , "\n" > /home/webapp/.ssh/rakam_ui && chmod 600 /home/webapp/.ssh/rakam_ui'
    EOH
  end
  
  include_recipe "rakam::update_ui"
else
  log "Ignoring BI module"
end

bash "download and build package" do
  code <<-EOH
    cd /home/webapp
    su webapp -l -c 'if cd rakam; then git pull origin master; else git clone https://github.com/buremba/rakam.git && cd rakam; fi; git checkout #{node['checkout']}'
    su webapp -l -c 'cd rakam; mvn clean install -DskipTests && rm -rf ../rakam-server && mv rakam/target/*-bundle/rakam-* ../rakam-server'
  EOH
end

template "/home/webapp/rakam-server/etc/config.properties" do
  source "config_#{node['deployment_type']}.properties.erb"
  owner "webapp"
  group "webapp"
  mode 0644
end

template "/home/webapp/rakam-server/etc/logging.properties" do
  source "logging.properties.erb"
  owner "webapp"
  group "webapp"
  variables ({ :version => `bash -c "cd home/webapp/rakam; git describe --tags"` })
  mode 0644
end

template "/home/webapp/rakam-server/etc/log.properties" do
  source "log.properties.erb"
  owner "webapp"
  group "webapp"
  mode 0644
end

template "/home/webapp/rakam-server/etc/jvm.config" do
  source "jvm.config.erb"
  owner "webapp"
  group "webapp"
  mode 0644
end
