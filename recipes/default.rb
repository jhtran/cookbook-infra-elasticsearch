#
# Cookbook Name:: infra-elasticsearch
# Recipe:: default
#
# Copyright 2013, AT&T Services Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
node.override["elasticsearch"]["allocated_memory"] = '4000m'
node.override["elasticsearch"]["cluster_name"] = 'foobar'
custom = {'indices.memory.index_buffer_size' => '50%',
          'index.refresh.interval' => 30,
          'index.translog.flush_threshold_ops' => 50000,
          'index.store.compress.stored' => true,
          'threadpool.search.type' => 'fixed',
          'threadpool.search.size' => 20,
          'threadpool.search.queue_size' => 100,
          'threadpool.bulk.type' => 'fixed',
          'threadpool.bulk.size' => 60,
          'threadpool.bulk.queue_size' => 300,
          'threadpool.index.type' => 'fixed',
          'threadpool.index.size' => 20,
          'threadpool.index.queue_size' => 100
         }
node.override["elasticsearch"]["custom_config"] = custom
node.override["elasticsearch"]["discovery"]["search_query"] =  "roles:infra-elasticsearch"
node.override["elasticsearch"]["plugins"]["karmi/elasticsearch-paramedic"] = {}
node.override["elasticsearch"]["allow_cluster_api"] = 'true'
node.override["elasticsearch"]["discovery"]["zen"]["minimum_master_nodes"] = '2'

include_recipe 'java'
include_recipe 'elasticsearch'
include_recipe 'elasticsearch::search_discovery'
include_recipe 'elasticsearch::plugins'
include_recipe 'elasticsearch::proxy'
