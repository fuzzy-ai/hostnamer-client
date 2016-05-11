fs = require "fs"

{print} = require "util"
{spawn} = require "child_process"

glob = require "glob"
_ = require 'lodash'

DOCKER = "fuzzyio/hostnamer"

cmd = (str, env, callback) ->
  if _.isFunction(env)
    callback = env
    env = null
  env = _.defaults(env, process.env)
  parts = str.split(" ")
  main = parts[0]
  rest = parts.slice(1)
  proc = spawn main, rest, {env: env}
  proc.stderr.on "data", (data) ->
    process.stderr.write data.toString()
  proc.stdout.on "data", (data) ->
    print data.toString()
  proc.on "exit", (code) ->
    callback?() if code is 0

build = (callback) ->
  cmd "coffee -c -o lib src", callback

buildDocker = (callback) ->
  cmd "docker build -t #{DOCKER} .", callback

buildTest = (callback) ->
  cmd "coffee -c test", callback

task "build", "Build lib/ from src/", ->
  build()

task "build-test", "Build for testing", ->
  invoke "clean"
  invoke "build"
  buildTest()

task "clean", "Clean up extra files", ->
  patterns = ["lib/*.js", "test/*.js", "*~", "lib/*~", "src/*~", "test/*~"]
  for pattern in patterns
    glob pattern, (err, files) ->
      for file in files
        fs.unlinkSync file

task "test", "Test the auth", ->
  invoke "clean"
  invoke "build"
  buildTest ->
    cmd "./node_modules/.bin/vows --spec -i test/*-test.js"

task "docker", "Build docker image", ->
  invoke "clean"
  build ->
    buildDocker()

task "push", "Push docker image", ->
  cmd "docker push #{DOCKER}"
