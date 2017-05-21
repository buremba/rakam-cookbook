default['java']['jdk_version'] = '8'
default['java']['remove_deprecated_packages'] = true
default['java']['oracle']['accept_oracle_download_terms'] = true
# default['java']['java_home'] = '/usr/lib/java/default'

default['java']['jdk']['8']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz'
default['java']['jdk']['8']['x86_64']['checksum'] = '62b215bdfb48bace523723cdbb2157c665e6a25429c73828a32f00e587301236'

default['java']['set_default'] = true
default['java_ark']['connect_timeout'] = 1200
default['maven']['install_java'] = false
default['maven']['3']['version'] = '3.2.5'
default['maven']['mavenrc']['opts'] = '-Dmaven.repo.local=$HOME/.m2/repository -Xmx384m'
