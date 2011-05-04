module Coloration
  module Writers
    module GeanyThemeWriter

      def build_result
 
      end

      protected

      def add_line(line="")
        (@lines ||= []) << line
      end

    end
  end
end
