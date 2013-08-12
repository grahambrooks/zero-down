require 'rake'

def mysql(cmd)
  system "mysql -uroot --execute '#{cmd}'"
end

desc 'Setup your local environment'
task :setup do
  system 'mysql -uroot < sql/create_database.sql'
  system 'mysql -uroot rolling < sql/createSchemaVersionTable.mysql.sql'

  system <<EOL
java -cp tools/mysql-connector-java-5.0.8-bin.jar:tools/dbdeploy-cli-3.0M3.jar \
   com.dbdeploy.CommandLineTarget \
   -D com.mysql.jdbc.Driver \
   --url jdbc:mysql://localhost/rolling \
   -d mysql \
   --userid root \
   --scriptdirectory sql/v1 \

EOL
  system 'mysql -uroot rolling < sql/create_users.sql'
  mysql "use rolling;SHOW TABLES;"
  mysql "use rolling;SELECT * FROM users;"
end

desc 'Tear down local environment'
task :teardown do
  mysql "DROP DATABASE rolling;"
end

desc 'Reload HAProxy configuration'
task :reload_proxy_config do
  command "haproxy -f cfg/haproxy.cfg -p $(<haproxy-private.pid) -st $(<haproxy-private.pid)"
end
