# hostnamer-client-server.coffee
# Copyright 2016 9165584 Canada Corporation <legal@fuzzy.io>
# All rights reserved.

async = require 'async'
Microservice = require 'fuzzy.io-microservice'

HostnamerClient = require './hostnamer-client'
version = require './version'

class HostnamerClientServer extends Microservice

  getName: ->
    "hostnamer-client"

  environmentToConfig: (env) ->

    cfg = super env

    cfg.hostnamerServer = env['HOSTNAMER_SERVER']
    cfg.hostnamerKey = env['HOSTNAMER_KEY']

    cfg

  setupRoutes: (exp) ->
    exp.get '/distribution', @appAuthc, @_reqHostnamerClient, @_getDistribution
    exp.get '/version', @_getVersion

  _reqHostnamerClient: (req, res, next) ->
    server = req.app.config.hostnamerServer
    key = req.app.config.hostnamerKey
    req.hostnamerClient = new HostnamerClient server, key
    next()

  _getDistribution: (req, res, next) ->

    if req.query?.count?
      try
        count = parseInt req.query.count, 10
      catch error
        return next new Error("'count' parameter must be an integer")
    else
      count = 100

    getHostname = (i, callback) ->
      req.hostnamerClient.hostname callback

    async.times count, getHostname, (err, hostnames) ->
      if err
        next err
      else
        distribution = {}
        for hostname in hostnames
          if distribution[hostname]?
            distribution[hostname] += 1
          else
            distribution[hostname] = 1
        res.json distribution

  _getVersion: (req, res, next) =>
    res.json {name: @getName(), version: version}

  startDatabase: (callback) ->
    callback null

  stopDatabase: (callback) ->
    callback null

module.exports = HostnamerClientServer
