include_attribute "deploy"

default[:delayed_job][:timeout] = 60
default[:delayed_job][:bin] = "bin/delayed_job"
default[:delayed_job][:suffix] = ""
default[:delayed_job][:options] = ""

node[:deploy].each do |application, deploy|
  if deploy[:delayed_job][:pool_size]
    default[:delayed_job][:workers] = deploy[:delayed_job][:pool_size].times.map{ {} }
  end

  if deploy[:delayed_job][:workers]
    default[:delayed_job][:workers] = deploy[:delayed_job][:workers]
  end
end
