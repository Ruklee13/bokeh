
define [
  "underscore",
  "jquery",
  "require",
  "./base",
], (_, $, require, base) ->

  bulk_save = (models) ->
    ##FIXME:hack
    Config = require("./base").Config
    doc = models[0].get('doc')
    jsondata = ({type: m.type, attributes:_.clone(m.attributes)} for m in models)
    jsondata = JSON.stringify(jsondata)
    url = Config.prefix + "/bokeh/bb/" + doc + "/bulkupsert"
    xhr = $.ajax(
      type: 'POST'
      url: url
      contentType: "application/json"
      data: jsondata
      header:
        client: "javascript"
    )
    xhr.done((data) ->
      load_models(data.modelspecs)
    )
    return xhr
