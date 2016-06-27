include_recipe 'clickhouse::service'

service 'clickhouse' do
  action :stop
end
