include_recipe 'presto::service'

service 'presto' do
  action :start
end
