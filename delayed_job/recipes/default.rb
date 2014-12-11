#
# Cookbook Name:: delayed_job
# Recipe:: default
#
# Copyright 2013, FreeRunning Technologies
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]
  default = node[:delayed_job]

  Chef::Log.debug("DELAYEDJOB::: Workers hash is #{default[:workers]}")

  workers = if default[:workers]
    default[:workers].each_with_index.map do |worker, i|
      identifier = worker[:identifier] || i
      {
        :timeout => worker[:timeout] || default[:timeout],
        :bin => worker[:bin] || default[:bin],
        :identifier => identifier,
        :suffix => ".#{identifier}",
        :options => worker[:options] || default[:options]
      }
    end
  else
    [default]
  end

  template "/etc/monit.d/#{application}_delayed_job.monitrc" do
    source 'delayed_job.monitrc.erb'
    owner 'root'
    group 'root'
    mode '0755'
    variables(
      :app => application,
      :env => deploy[:rails_env],
      :dir => deploy[:deploy_to],
      :user => deploy[:user],
      :group => deploy[:group],
      :workers => workers
    )
    only_if { deploy[:delayed_job] }
  end
end

bash 'monit-reload' do
  user 'root'
  code 'monit reload'
end
