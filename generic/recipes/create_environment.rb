include_recipe 'java::oracle'

include_recipe 'ark::default'

ark 'maven' do
  url             'http://apache.mirrors.tds.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz'
  checksum        '6e3e9c949ab4695a204f74038717aa7b2689b1be94875899ac1b3fe42800ff82'
  home_dir        '/usr/local/maven'
  win_install_dir '/usr/local/maven'
  version         '3.3.9'
  append_env_path true
end

user 'webapp' do
  comment 'Web application user'
  home '/home/webapp'
  shell '/bin/bash'
end

bash "create application user" do
  code <<-EOH
    su webapp -l -c 'mkdir -p /home/webapp/.ssh && ssh-keyscan github.com >> /home/webapp/.ssh/known_hosts'
  EOH
end
