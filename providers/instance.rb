#
# Cookbook Name:: mongodb
# Provider:: instance
#
# Copyright 2013 Blake Imsland
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

action :create do
  name = new_resource.name
  logpath = new_resource.logpath || "/var/log/mongodb/mongodb-#{name}.log"
  dbpath = new_resource.dbpath || "/data/mongodb/#{name}"

  #template "mongodb-#{name}-upstart" do
  #  path "/etc/init/mongodb-#{name}.conf"
  #  source "mongodb_upstart.erb"
  #  variables({
  #    :name => name,
  #  })
  #  notifies :restart, "service[mongodb_#{name}]"
  #end

  template "mongodb-#{name}-sysvinit" do
    path "/etc/init.d/mongodb-#{name}"
    source "mongodb_sysvinit.erb"
    cookbook "mongodb"
    variables({
      :name => name,
    })
    notifies :restart, "service[mongodb-#{name}]"
  end

  template "mongodb-#{name}-config" do
    path "/etc/default/mongodb-#{name}"
    source "mongodb_default.erb"
    cookbook "mongodb"
    variables({
      :name => name,
      :port => new_resource.port,
      :bind_ip => new_resource.bind_ip,
      :logpath => logpath,
      :auth => new_resource.auth,
      :dbpath => dbpath,
      :quota_files => new_resource.quota_files,
      :repl_set => new_resource.repl_set,
    })
    notifies :restart, "service[mongodb-#{name}]"
  end

  directory dbpath do
    owner 'mongodb'
    group 'mongodb'
    mode 0755
    recursive true
  end

  directory ::File.dirname(logpath) do
    owner 'mongodb'
    group 'mongodb'
    mode 0755
    recursive true
  end

  #link "mongodb-#{name}-init" do
  #  target_file "/etc/init.d/mongodb_#{name}"
  #  to '/lib/init/upstart-job'
  #end

  #service "mongodb-#{name}" do
  #  provider Chef::Provider::Service::Upstart
  #  action [:start, :enable]
  #end

  service "mongodb-#{name}" do
    provider Chef::Provider::Service::Init::Debian
    action [:start, :enable]
  end

  new_resource.updated_by_last_action(true)
end

action :destroy do
  name = new_resource.name
  logpath = new_resource.logpath || "/var/log/mongodb/mongodb-#{name}.log"
  dbpath = new_resource.dbpath || "/data/mongodb/#{name}"

  #service "mongodb-#{name}" do
  #  provider Chef::Provider::Service::Upstart
  #  action [:stop, :disable]
  #end

  service "mongodb-#{name}" do
    provider Chef::Provider::Service::Init::Debian
    action [:stop, :disable]
  end

  #file "/etc/init/mongodb-#{name}.conf" do
  #  action :delete
  #end

  file "/etc/default/mongodb-#{name}" do
    action :delete
  end

  #link "/etc/init.d/mongodb-#{name}" do
  #  action :delete
  #end

  file "/etc/init.d/mongodb-#{name}" do
    action :delete
  end

  file logpath do
    action :delete
  end

  directory dbpath do
    recursive true
    action :delete
  end
end
