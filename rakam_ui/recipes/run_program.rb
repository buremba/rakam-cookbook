bash "install-codedeploy-agent" do
  code <<-EOH
    cd /var/www
    git clone git@github.com:buremba/rakam.git
    cd rakam && mvn clean install -DskipTests -Pbundled-with-ui -Pmove-package-to-dependency
  EOH
end
