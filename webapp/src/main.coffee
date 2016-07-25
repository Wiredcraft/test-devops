require('source-map-support').install()
os = require 'os'
Path    = require 'path'
Koa     = require 'koa'
KLogger = require 'koa-logger'
KBody   = require 'koa-body'
KStatic = require 'koa-static'
Jade    = require 'koa-jade'
Mount   = require 'koa-mount'
Router  = require 'koa-router'

config  = require './config'

Mongo = require 'mongoose'
Mongo.connect config.mongodb.url


schema = new Mongo.Schema
  text: String
  client: String
  server: String

Question = Mongo.model 'Question',schema

app = new Koa
app.use KLogger()
app.use KBody()
app.use Mount "/public", KStatic('public',maxage: 3600)
app.use Mount "/public", -> yield return @status=404

views = new Jade
  viewPath: Path.resolve __dirname,'../public'
  locals: config: config

app.use views.middleware

router = new Router
router.get '/', ->
  list = yield Question.find().sort {_id:-1}
  list = [] if list is undefined
  hostname = os.hostname()
  @render 'index',{list,hostname}
  yield return

router.post '/add', ->
  #console.info @request.body
  q = new Question
    text: @request.body.q
    client: @request.ip
    server: os.hostname()
  yield q.save() if q.text
  @redirect '/'
  yield return

app.use router.routes()
app.use router.allowedMethods()

[host,port] = config.httpd.listen.split ':'
[port,host] = [host,'0.0.0.0'] if port is undefined
if host is 'unix'
  app.listen port, -> console.info "Listening on #{host}:#{port}"
else
  app.listen port, host, -> console.info "Listening on #{host}:#{port}"

