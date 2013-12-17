h = Sx.ViewHelpers

describe "Sx.ViewHelpers", ->
  describe "#safeString", ->
    it 'returns a string with "htmlSafe" = true', ->
      safe = h.safeString('bla')
      expect(safe.htmlSafe).toBe(true)

  describe "#escapeIfUnsafe", ->
    describe 'when string is safe', ->
      it 'returns it', ->
        safe = h.safeString('bla')
        expect(h.escapeIfUnsafe(safe)).toEqual('bla')

    describe 'when string is not safe', ->
      it 'escapes it', ->
        expect(h.escapeIfUnsafe('unsafe>')).toEqual('unsafe&gt;')
        
  describe "#attributesToString", ->
    it 'returns "" when no attributes', ->
      expect(h.attributesToString({})).toEqual ''

    it 'escapes the key and value', ->
      attribs = { key1: 'value1>', 'key2"': 'value2&' }
      expect(h.attributesToString(attribs)).toEqual \
        " key1='value1&gt;' key2&quot;='value2&amp;'"

  describe "#contentTag", ->
    it 'returns a safe string', ->
      expect(h.contentTag('div', '').htmlSafe).toBe(true)
    it 'escapes the contents', ->
      expect(h.contentTag('div', 'bla>')).toEqual '<div>bla&gt;</div>'
    it 'escapes the attributes', ->
      html = h.contentTag('a', 'next>', href: 'one&two', name: 'bob').toString()
      expect(html).toEqual \
        "<a href='one&amp;two' name='bob'>next&gt;</a>"

  describe "#linkTo", ->
    it 'returns an anchor', ->
      expect(h.linkTo('the-text', 'the-href')).toEqual \
        "<a href='the-href'>the-text</a>"
    it 'allows using html contents (safe)', ->
      content = h.contentTag('i', '', class: 'icon-ok')
      expect(h.linkTo(content, 'the-href').toString()).toEqual \
        "<a href='the-href'><i class='icon-ok'></i></a>"
      
  describe "#bootstrapControl", ->
    it 'returns a bootstrap control group', ->
      html = h.bootstrapControl('the-label', 'the-id', 'the-contents')
      expect(html.toString()).toEqual \
        "<div class='control-group'>" +
          "<label class='control-label' for='the-id'>the-label</label>" +
          "<div class='controls'>the-contents</div>" +
          "</div>"

  describe "#bootstrapTextField", ->
    it 'returns a bootstrap text field', ->
      attribs = { class: 'a-class', value: 'the-value' }
      html = h.bootstrapTextField('the-label', 'the-id', attribs)
      expect(html.toString()).toEqual \
        "<div class='control-group'>" +
          "<label class='control-label' for='the-id'>the-label</label>" +
          "<div class='controls'>" +
            "<input class='a-class' value='the-value' type='text' " +
            "id='the-id' name='the-id'></input>" +
          "</div>" +
        "</div>"

  describe "#bootstrapTextArea", ->
    it 'returns a bootstrap text area', ->
      attribs = { class: 'a-class', value: 'the-value' }
      html = h.bootstrapTextArea('the-label', 'the-id', attribs)
      expect(html.toString()).toEqual \
        "<div class='control-group'>" +
          "<label class='control-label' for='the-id'>the-label</label>" +
          "<div class='controls'>" +
            "<textarea class='a-class' value='the-value' " +
            "id='the-id' name='the-id' rows='5'></textarea>" +
          "</div>" +
        "</div>"
      
  describe "#radio", ->
    it 'returns a radio button', ->
      html = h.radio('the-label', 'the-name', 'the-value')
      expect(html.toString()).toEqual \
        "<label class='radio'>" +
          "<input type='radio' id='the-name-the-value' name='the-name' " +
            "value='the-value'></input>" +
          "the-label" +
        "</label>"
      
    it 'supports disabled radio buttons', ->
      html = h.radio('the-label', 'the-name', 'the-value', disabled: 'disabled')
      expect(html.toString()).toEqual \
        "<label class='radio'>" +
          "<input disabled='disabled' type='radio' id='the-name-the-value' " +
            "name='the-name' value='the-value'></input>" +
          "the-label" +
        "</label>"

  describe "#bootstrap3Control", ->
    it 'returns a bootstrap3 control group', ->
      html = h.bootstrap3Control('the-label', 'the-id', 'the-contents',
        labelWidth: 4)
      expect(html.toString()).toEqual \
        "<div class='form-group'>" +
          "<label class='control-label col-sm-4' for='the-id'>" +
            "the-label</label>" +
          "<div class='controls col-sm-8'>the-contents</div>" +
          "</div>"

  describe "#bootstrap3TextField", ->
    it 'returns a bootstrap3 text field', ->
      attribs = { class: 'a-class', value: 'the-value', labelWidth: 3 }
      html = h.bootstrap3TextField('the-label', 'the-id', attribs)
      expect(html.toString()).toEqual \
        "<div class='form-group'>" +
          "<label class='control-label col-sm-3' for='the-id'>" +
            "the-label</label>" +
          "<div class='controls col-sm-9'>" +
            "<input class='a-class form-control' value='the-value' " +
              "type='text' id='the-id' name='the-id'></input>" +
          "</div>" +
        "</div>"

  describe "#bootstrap3TextArea", ->
    it 'returns a bootstrap3 text area', ->
      attribs = { class: 'a-class', value: 'the-value' }
      html = h.bootstrap3TextArea('the-label', 'the-id', attribs)
      expect(html.toString()).toEqual \
        "<div class='form-group'>" +
          "<label class='control-label col-sm-3' for='the-id'>" +
            "the-label</label>" +
          "<div class='controls col-sm-9'>" +
            "<textarea class='a-class form-control' value='the-value' " +
            "id='the-id' name='the-id' rows='5'></textarea>" +
          "</div>" +
        "</div>"

