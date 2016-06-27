bash "download-and-setup-presto" do
  code <<-EOH
    mkdir -p /etc/apt/sources.list.d && \
    echo "deb http://repo.yandex.ru/clickhouse/trusty/ dists/stable/main/binary-amd64/" | tee /etc/apt/sources.list.d/clickhouse.list && \
    apt-get update && \
    apt-get install --allow-unauthenticated -y clickhouse-server-common && \
    rm -rf /var/lib/apt/lists/* /var/cache/
    chown -R metrika /etc/clickhouse-server/
  EOH
end

template "/etc/clickhouse-server/config.xml" do
  source "config.xml.erb"
  owner "metrika"
  group "metrika"
  mode 0755
end
