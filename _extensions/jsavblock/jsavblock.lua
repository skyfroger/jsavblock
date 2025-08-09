local function writeEnvironments()
  if quarto.doc.is_format("html:js") then
    quarto.doc.add_html_dependency({
      name = "jquery",
      version = "2.2.4",
      scripts = {
        { path = "js/jquery.min.js", afterBody = "true" },
        { path = "js/jquery-ui.min.js", afterBody = "true" },
        { path = "js/jquery.transit.js", afterBody = "true" }
      }
    })
    quarto.doc.add_html_dependency({
      name = "JSAV",
      version = "1.0.1",
      scripts = {
        { path = "js/raphael.js", afterBody = "true" },
        { path = "js/dagre.min.js", afterBody = "true" },
        { path = "js/JSAV-min.js",    afterBody = "true" },
      },
      stylesheets = { "css/JSAV.css", "css/styles.css" }
    })
  end
end


function createJSAV(div)
  writeEnvironments()
  local divControls = pandoc.Div({}, {class = "jsavcontrols"})
  local divOutput = pandoc.Div({}, {class = "jsavoutput jsavline"})
  local spanCounter = pandoc.Span({}, {class = "jsavcounter"})
  
  table.insert(div.content, spanCounter)
  table.insert(div.content, divControls)
  table.insert(div.content, divOutput)
  return div
end

if quarto.doc.isFormat("html:js") then
  Div = function(div)
    if div.classes:includes("jsavblock") then
      return createJSAV(div)
    end
  end
end