bash "install-codedeploy-agent" do
  code <<-EOH
    #{Chef::Config[:file_cache_path]}/codedeploy-agent-install auto
  EOH
end
