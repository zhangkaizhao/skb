module XMLOptions
  HTML_PARSER_OPTIONS = XML::HTMLParserOptions.default | XML::HTMLParserOptions::NODEFDTD
  XML_SAVE_OPTIONS = XML::SaveOptions::FORMAT | XML::SaveOptions::AS_HTML
end
