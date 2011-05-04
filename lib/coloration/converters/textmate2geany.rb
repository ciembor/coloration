module Coloration
  module Converters
    class Textmate2GeanyConverter < AbstractConverter
      @in_theme_type = "Textmate"
      @in_theme_ext = "tmTheme"
      @out_theme_type = "Geany"
      @out_theme_ext = "geany"
      include Readers::TextMateThemeReader
      include Writers::GeanyThemeWriter
    end
  end
end
