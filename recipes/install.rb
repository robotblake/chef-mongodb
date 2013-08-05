#
# Cookbook Name:: mongodb
# Recipe:: install
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

#apt_repository '10gen' do
#  uri 'http://downloads-distro.mongodb.org/repo/ubuntu-upstart'
#  distribution 'dist'
#  components ['10gen']
#  keyserver 'hkp://keyserver.ubuntu.com:80'
#  key '7F0CEB10'
#end

apt_repository '10gen' do
  uri 'http://downloads-distro.mongodb.org/repo/debian-sysvinit'
  distribution 'dist'
  components ['10gen']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key '7F0CEB10'
end

package 'mongodb-10gen'

#service 'mongodb' do
#  provider Chef::Provider::Service::Upstart
#  action [:stop, :disable]
#end

service 'mongodb' do
  provider Chef::Provider::Service::Init::Debian
  action [:stop, :disable]
end

chef_gem 'mongo'
