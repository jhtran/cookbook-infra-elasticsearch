#
# Cookbook Name:: infra-elasticsearch
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
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
# temporary workaround for chef broken search role:elasticsearch"
node.override["elasticsearch"]["discovery"]["search_query"] =  "name:c1r2.int.bwi1.attcompute.com OR name:c2r2.int.bwi1.attcompute.com OR name:c3r2.int.bwi1.attcompute.com"
node.override["elasticsearch"]["plugins"]["karmi/elasticsearch-paramedic"] = {}
node.override["elasticsearch"]["nginx"]["users"] = [{ "username"=> "foo", "password"=> "bar" }]
node.override["elasticsearch"]["allow_cluster_api"] = 'true'
node.override["elasticsearch"]["discovery"]["zen"]["minimum_master_nodes"] = '2'

include_recipe 'java'
include_recipe 'elasticsearch'
include_recipe 'elasticsearch::search_discovery'
include_recipe 'elasticsearch::plugins'
include_recipe 'elasticsearch::proxy'
