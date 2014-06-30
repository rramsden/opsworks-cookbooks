node[:deploy].each do |application, deploy|
  dotenv_template do
    application application
    deploy deploy
    env node[:deploy][application.to_sym][:env]
  end
end
