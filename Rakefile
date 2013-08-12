require 'rake'

def mysql(cmd)
  system "mysql -uroot --execute '#{cmd}'"
end

desc 'Setup your local environment'
task :setup do
  mysql "CREATE DATABASE rolling;"
  system "mysql -uroot rolling < tools/createSchemaVersionTable.mysql.sql"

  system <<EOL
java -cp tools/mysql-connector-java-5.0.8-bin.jar:tools/dbdeploy-cli-3.0M3.jar \
   com.dbdeploy.CommandLineTarget \
   -D com.mysql.jdbc.Driver \
   --url jdbc:mysql://localhost/rolling \
   -d mysql \
   --userid root \
   --scriptdirectory migrations/v1 \

EOL
  system "mysql -uroot rolling < users.sql"
  mysql "use rolling;SHOW TABLES;"
end

desc 'Tear down local environment'
task :teardown do
  mysql "DROP DATABASE rolling;"
end

