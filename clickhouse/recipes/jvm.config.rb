-Xmx4G
-DXX:OnOutOfMemoryError=kill -9 %p
-Djava.util.logging.config.file=/home/webapp/worker/etc/logging.properties
<%= node["jvm-properties"] %>