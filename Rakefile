require 'rake'

def mysql(cmd)
  system "mysql -uroot --execute '#{cmd}'"
end

def dbdeploy(path)
  cmd = <<EOL
java -cp tools/mysql-connector-java-5.0.8-bin.jar:tools/dbdeploy-cli-3.0M3.jar \
   com.dbdeploy.CommandLineTarget \
   -D com.mysql.jdbc.Driver \
   --url jdbc:mysql://localhost/rolling \
   -d mysql \
   --userid root \
   --delimiter // \
   --scriptdirectory {path} \

EOL

  system cmd.sub('{path}', path)
end

task :default => [:setup_environment, :upgrade_prep, :post_deploy_cleanup]

desc 'Setup your local environment'
task :setup_environment do
  system 'mysql -uroot < sql/create_database.sql'
  system 'mysql -uroot rolling < sql/createSchemaVersionTable.mysql.sql'

  dbdeploy 'sql/v1'

  system 'mysql -uroot rolling < sql/create_users.sql'
  mysql "use rolling;SHOW TABLES;"
  mysql "use rolling;SELECT * FROM users;"
end


desc 'Upgrade prep'
task :upgrade_prep do
  puts "Upgrade preparation"

  dbdeploy 'sql/v2'
end

desc 'Clean up after deployment'
task :post_deploy_cleanup do
  dbdeploy 'sql/v3'
end

desc 'Tear down local environment'
task :teardown do
  mysql "DROP DATABASE rolling;"
end

desc 'Reload HAProxy configuration'
task :reload_proxy_config do
  command "haproxy -f cfg/haproxy.cfg -p $(<haproxy-private.pid) -st $(<haproxy-private.pid)"
end
