include_recipe 'java::oracle'

bash "update packages" do
  code <<-EOH
    apt-get update
  EOH
end

include_recipe 'ark::default'

ark 'maven' do
  url             'http://apache.mirrors.tds.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz'
  checksum        '8c190264bdf591ff9f1268dc0ad940a2726f9e958e367716a09b8aaa7e74a755'
  home_dir        '/usr/local/maven'
  win_install_dir '/usr/local/maven'
  version         '3.3.9'
  append_env_path true
end

bash "install git" do
  code <<-EOH
    apt-get install git -y;
  EOH
end

bash "create application user" do
  code <<-EOH
    adduser --system --shell /bin/bash --group --disabled-password --home /home/webapp webapp
    su webapp -l -c 'mkdir -p /home/webapp/.ssh && ssh-keyscan github.com >> /home/webapp/.ssh/known_hosts'
  EOH
end
