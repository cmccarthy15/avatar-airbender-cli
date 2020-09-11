require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "db/development.sqlite3"
)

ActiveRecord::Base.logger = Logger.new(STDOUT)
# Comment out line above and uncomment out line below to remove logger when presenting
# ActiveRecord::Base.logger =  nil

require_all 'app'
