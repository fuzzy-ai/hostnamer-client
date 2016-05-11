# hostnamer-server.coffee
# Copyright 2016 9165584 Canada Corporation <legal@fuzzy.io>
# All rights reserved.

os = require 'os'

Microservice = require 'fuzzy.io-microservice'

version = require './version'

class HostnamerServer extends Microservice

  getName: ->
    "hostnamer"

  setupRoutes: (exp) ->
    exp.get '/hostname', @appAuthc, @_getHostname
    exp.get '/version', @_getVersion

  _getHostname: (req, res, next) ->
    hostname = os.hostname()
    res.json hostname

  _getVersion: (req, res, next) =>
    res.json {name: @getName(), version: version}

  startDatabase: (callback) ->
    callback null

  stopDatabase: (callback) ->
    callback null

module.exports = HostnamerServer
