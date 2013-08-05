#
# Cookbook Name:: mongodb
# Resource:: instance
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

actions :create
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :port, :kind_of => Integer, :default => 27017
attribute :bind_ip, :kind_of => [String, NilClass], :default => nil
attribute :logpath, :kind_of => [String, NilClass], :default => nil
attribute :auth, :kind_of => [TrueClass, FalseClass], :default => false
attribute :dbpath, :kind_of => [String, NilClass], :default => nil
attribute :quota_files, :kind_of => [Integer, NilClass], :default => nil
attribute :repl_set, :kind_of => [String, NilClass], :default => nil
