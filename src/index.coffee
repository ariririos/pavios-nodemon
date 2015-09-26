'use strict'

taskName = 'Nodemon' # used with humans
safeTaskName = 'nodemon' # used with machines

nodemon = require 'nodemon'

{getConfig, gulp, API: {reload, typeCheck, debug}} = require 'pavios'
debug = debug 'task:' + taskName

config = getConfig safeTaskName

result = typeCheck.raw 'Object', config
debug 'Type check ' + (if result then 'passed' else 'failed')

unless result
  typeCheck.typeCheckErr taskName

gulp.task safeTaskName, (cb) ->
  unless result
    debug 'Exiting task early because config is invalid'
    return cb()

  nodemon config
  .on 'restart', ->
    debug 'Restarting server...'
    reload()

  cb()

module.exports.order = 2
