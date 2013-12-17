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

  bootstrapTextField: (label, id, attributes = {}) ->
    attributes.type or= 'text'
    attributes.id or= id
    attributes.name or= id
    control = @contentTag 'input', '', attributes
    @bootstrapControl(label, id, control)

  bootstrapTextArea: (label, id, attributes = {}) ->
    attributes.id or= id
    attributes.name or= id
    attributes.rows or= 5
    control = @contentTag 'textarea', '', attributes
    @bootstrapControl(label, id, control)

  bootstrap3Control: (label, id, control, options) ->
    labelWidth = options.labelWidth or 3
    controlsWidth = 12 - labelWidth
    label = @contentTag 'label', label,
      class: "control-label col-sm-#{labelWidth}",
      for: id
    controls = @contentTag 'div', control,
      class: "controls col-sm-#{controlsWidth}"
    @contentTag 'div', @safeString(label + controls), class: 'form-group'

  bootstrap3TextField: (label, id, attributes = {}) ->
    bsOptions = @_getBootstrapOptions(attributes)
    attributes.type or= 'text'
    attributes.id or= id
    attributes.name or= id
    attributes.class = @_addClass(attributes.class, 'form-control')
    control = @contentTag 'input', '', attributes
    @bootstrap3Control(label, id, control, bsOptions)

  bootstrap3TextArea: (label, id, attributes = {}) ->
    bsOptions = @_getBootstrapOptions(attributes)
    attributes.id or= id
    attributes.name or= id
    attributes.rows or= 5
    attributes.class = @_addClass(attributes.class, 'form-control')
    control = @contentTag 'textarea', '', attributes
    @bootstrap3Control(label, id, control, bsOptions)

  _addClass: (existingClass, newClass) ->
    if existingClass?
      "#{existingClass} #{newClass}"
    else
      newClass

  _getBootstrapOptions: (options) ->
    bsOptions = {}
    for name in ['labelWidth']
      if options[name]?
        bsOptions[name] = options[name]
        delete options[name]
    bsOptions


  radio: (label, name, value, attributes = {}) ->
    attributes.type or= 'radio'
    attributes.id or= "#{name}-#{value}"
    attributes.name or= name
    attributes.value or= value
    radio = @contentTag 'input', '', attributes
    contents = @safeString(radio + label)
    @contentTag 'label', contents, class: 'radio'

