bash "download-and-setup-clickhouse" do
  code <<-EOH
    mkdir -p /etc/apt/sources.list.d && \
    echo "deb http://repo.yandex.ru/clickhouse/trusty/ dists/stable/main/binary-amd64/" | tee /etc/apt/sources.list.d/clickhouse.list && \
    apt-get update && \
    apt-get install --allow-unauthenticated -y clickhouse-server-common clickhouse-client && \
    chown -R metrika /etc/clickhouse-server/
    sudo apt-get install jq
  EOH
end

bash "download and worker" do
  code <<-EOH
    cd /home/webapp
    su webapp -l -c 'if cd rakam-clickhouse-worker; then git pull; else git clone https://github.com/buremba/rakam-clickhouse-worker.git && cd rakam-clickhouse-worker; fi; git checkout #{node['checkout']}'
    su webapp -l -c 'cd rakam-clickhouse-worker; mvn clean install -DskipTests && rm -rf ../worker/lib && if [ -f '../worker' ] ; then mv target/*-bundle/clickhouse-worker-*/lib ../worker/lib; else mv target/*-bundle/clickhouse-worker-*/ ../worker; fi;'
  EOH
end

template "/home/webapp/worker/etc/config.properties" do
  source "config_worker.properties.erb"
  owner "webapp"
  group "webapp"
  mode 0755
end

bash "run worker" do
  code <<-EOH
    su webapp -l -c 'cd /home/webapp/worker; bin/launcher restart'
  EOH
end

template "/etc/clickhouse-server/config.xml" do
  source "config.xml.erb"
  owner "metrika"
  group "metrika"
  mode 0755
end
