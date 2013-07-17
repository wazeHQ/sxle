#= require sx
#= require hamlcoffee

Sx.ViewHelpers = {}

$e = HAML.escape
$c = HAML.cleanValue

hamlGlobals =
  t: -> I18n.t.apply(I18n, arguments)
  h: Sx.ViewHelpers
  safe_t: (key, variables) ->
    vars = {}
    for own name, value of variables
      vars[name] = "%{#{name}}"

    text = HAML.escape(I18n.t(key, vars))

    for own name, value of variables
      value = HAML.escape(value) unless value.htmlSafe
      text = text.replace(new RegExp("%\\{" + name + "\\}"), value)

    text


window.HAML.globals = -> hamlGlobals

$.extend Sx.ViewHelpers,
  safeString: (string) ->
    res = new String(string)
    res.htmlSafe = true
    res

  escapeIfUnsafe: (text) ->
    text = $e($c(text)) unless text.htmlSafe
    text

  attributesToString: (attributes) ->
    return '' if $.isEmptyObject(attributes)
    items = []
    for own key, value of attributes
      items.push "#{$e($c(key))}='#{$e($c(value))}'"
    ' ' + items.join(' ')

  contentTag: (tagName, content = '', attributes = {}) ->
    attributesString = @attributesToString(attributes)
    startTag = "<#{tagName}#{attributesString}>"
    content  = @escapeIfUnsafe(content)
    endTag   = "</#{tagName}>"
    @safeString(startTag + content + endTag)

  linkTo: (text, href) ->
    @contentTag('a', text, href: href)

  bootstrapControl: (label, id, control) ->
    label = @contentTag 'label', label, class: 'control-label', for: id
    controls = @contentTag 'div', control, class: 'controls'
    @contentTag 'div', @safeString(label + controls), class: 'control-group'

  textField: (label, id, attributes = {}) ->
    attributes.type or= 'text'
    attributes.id or= id
    attributes.name or= id
    control = @contentTag 'input', '', attributes
    @bootstrapControl(label, id, control)

  radio: (label, name, value, attributes = {}) ->
    attributes.type or= 'radio'
    attributes.id or= "#{name}-#{value}"
    attributes.name or= name
    attributes.value or= value
    radio = @contentTag 'input', '', attributes
    label = @contentTag 'label', label, for: attributes.id
    @safeString(radio + label)
