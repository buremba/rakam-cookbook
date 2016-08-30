bash "run program" do
  code <<-EOH
    su webapp -l -c 'if [ -d '/home/webapp/presto' ]; then /home/webapp/presto/bin/launcher stop; fi'
  EOH
end