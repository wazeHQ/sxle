window.HAML =
  escape: (text) ->
    ("" + text)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#39;")
      .replace(/\//g, "&#47;")

  cleanValue: (text) ->
    switch text
      when null, undefined then ''
      when true, false then '\u0093' + text
      else text
