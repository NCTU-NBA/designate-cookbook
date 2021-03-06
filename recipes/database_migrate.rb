# Copyright 2013 Hewlett-Packard Development Company, L.P.
#
# Author: Kiall Mac Innes <kiall@hp.com>
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
include_recipe "designate::common"

# Init the database, this will fail all but the first time..
execute "designate-manage database-init" do
  ignore_failure  true
  action          :run
end

# Run the DB migrations
execute "designate-manage database-sync" do

  action          :run
end

# Run the DB migrations
file "/var/lib/designate/designate.sqlite" do
  owner           "designate"
  group           "designate"
  only_if         { File.exists?("/var/lib/designate/designate.sqlite") }
end
