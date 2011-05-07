module Coloration
  module Writers
    module GeanyThemeWriter

      def build_result
      
		# [theme_info] section
		
        add_line("[theme_info]")
		add_line("name=#{name}")
		add_line("description=#{comment} (converted from TextMate to Geany with Coloration)")

		add_line
		
		# [named_styles] section
		#
		# style names to use in filetypes.* [styling] sections
		# use foreground;background;bold;italic
		# normally background should be left blank to use the "default" style
		
		add_line("[named_styles]")
		add_comment("see filetypes.common for details")
		
		add_line("")
		
		
		ui_mapping = {
		
		  # This is the default style. It is used for styling files without a filetype set.
          "default"            		=> [ @ui["foreground"], @ui["background"], "false", "false" ],
          
          # 3rd selection argument is true to override default foreground
		  # 4th selection argument is true to override default background
          "selection"				=> [ "", @ui["selection"], "", "true" ],
          
          # colour of the caret(the blinking cursor), only first and third argument is interpreted
		  # set the third argument to true to change the caret into a block caret
		  "caret"					=> [ @ui["caret"], "", "false" ],
		  
		  # The style for coloring the white space if it is shown. 
		  # The first both arguments define the foreground and background colors, 
		  # the third argument sets whether to use the defined foreground color 
		  # or to use the color defined by each filetype for the white space. 
		  # The fourth argument defines whether to use the background color.
          "white_space"    		    => [ @ui["invisibles"], "", "true", "false" ],
          
          # The style for coloring the background of the current line. 
          # Only the second and third arguments are interpreted. 
          # The second argument is the background color. 
          # Use the third argument to enable or disable background highlighting 
          # for the current line (has to be true/false).
          
          # marker line??????????????????????????????????
          "current_line"		    => [ "", @ui["lineHighlight"], "true", "" ]
          
        }
        
		/*
		
        default=0x000000;0xffffff
		comment=0x808080
		commentdoc=0x404000
		number=0x400080
		keyword=0x600080;;true
		keyword2=0x9f0200;;true
		string=0x008000
		preprocessor=0x808000
		operator=0x300080
		stringeol=0x000000;0xe0c0e0
		type=0x003030;;true
		function=0x000080
		extra=0x404080
		
		*/
		
      end

      protected

      def add_line(line="")
        (@lines ||= []) << line
      end

      def format_comment(text)
        "# #{text}"
      end

    end
  end
end
