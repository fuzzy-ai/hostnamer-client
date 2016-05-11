# main.coffee
# Copyright 2016 9165584 Canada Corporation <legal@fuzzy.io>
# All rights reserved.

HostnamerClientServer = require './hostnamer-client-server'

server = new HostnamerClientServer(process.env)

server.start (err) ->
  if err
    console.error(err)
  else
    console.log("Server started.")

# Try to send a slack message on error

process.on 'uncaughtException', (err) ->
  if server? and server.slackMessage?
    msg = "UNCAUGHT EXCEPTION: #{err.message}"
    server.slackMessage "error", msg, ":bomb:", (err) ->
      if err?
        console.error err
