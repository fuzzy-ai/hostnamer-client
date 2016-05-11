# hostnamer-client.coffee
# Copyright 2016 9165584 Canada Corporation <legal@fuzzy.io>
# All rights reserved.

MicroserviceClient = require 'fuzzy.io-microservice-client'

class HostnamerClient extends MicroserviceClient

  hostname: (callback) ->
    @get "/hostname", callback

  version: (callback) ->
    @get "/version", callback

module.exports = HostnamerClient
