namespace :redis do
  desc "Install the latest release of Redis"
  task :install, roles: :app do
    run "#{sudo} add-apt-repository ppa:chris-lea/redis-server", :pty => true do |ch, stream, data|
      press_enter(ch, stream, data)
    end
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install redis-server"
  end
  after "deploy:install", "redis:install"

  %w[start stop restart].each do |command|
    desc "#{command} redis"
    task command, roles: :web do
      run "#{sudo} service redis-server #{command}"
    end
  end
end