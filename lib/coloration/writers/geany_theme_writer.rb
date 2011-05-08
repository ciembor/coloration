module Coloration
  module Writers
    module GeanyThemeWriter

      def build_result
        
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
      
		# [theme_info] section
		
        add_line("[theme_info]")
		add_line("name=#{name}")
		add_line("description=")
		add_line("version=")
		add_line("author=")
		add_line("url=")
		
		# [named_styles] section
		#
		# style names to use in filetypes.* [styling] sections
		# use foreground;background;bold;italic
		# normally background should be left blank to use the "default" style

		add_line	
		add_line("[named_styles]")
		add_line
		
#		default=
#		error=															@items["invalid"]
		
		add_line
		add_comment("Editor styles")
		add_hr
		add_line 
		
#			selection=0x000000;0x676B65;false;true
#			current_line=0x000000;0x545752;true
#		brace_good=0x966DBE;;true
#		brace_bad=0x2B2B2B;0xDA4939;true
#		margin_line_number=0x2B2B2B;0xC0C0FF
#		margin_folding=0x000000;0xdfdfdf
#		fold_symbol_highlight=
#		indent_guide=
#			caret=
#		marker_line=													@ui["invisibles"] ?
#		marker_search=													@ui["invisibles"] ?
#		marker_mark=													@ui["invisibles"] ?
#			white_space=0x565656;;true
		
		add_line
		add_comment("Generic programming languages")
		add_hr
		add_line 

#		comment=0xBC9458;;;true											@items["comment"]
#		comment_doc=comment
#		comment_line=comment
#		comment_line_doc=comment_doc
#		comment_doc_keyword=comment_doc,bold
#		comment_doc_keyword_error=comment_doc,italic
#
#		number=															@items["constant.numeric"]
#		number_1=number
#		number_2=number_1
#
#		type=0xDA4939;;true												@items["entity.name.type"]
#		class=type														@items["entity.name.class"]
#		function=0xFFC66D												@items["entity.name.function"]
#		parameter=function												variable.parameter ?
#
#		keyword=0xCC7833;;true											@items["keyword"]
#		keyword_1=keyword
#		keyword_2=0x6D9CBE;;true
#		keyword_3=keyword_1
#		keyword_4=keyword_1
#
#		identifier=default												storage.type ?
#		identifier_1=identifier
#		identifier_2=identifier_1
#		identifier_3=identifier_1
#		identifier_4=identifier_1
#
#		string=															@items["string,string.quoted"]
#		string_1=string
#		string_2=string_1
#		string_eol=string_1,italic
#		character=string_1												@items["constant.character"]
#		backtick=string_2
#		here_doc=string_2
#
#		label=default,bold												@items["constant.other.symbol"]
#		preprocessor=0xE6E1DC											other.preprocessor
#		regex=number_1													@items["string.regexp"]
#		operator=default												@items["keyword.operator"]
#		decorator=string_1,bold
#		other=default

		add_line
		add_comment("Markup-type languages")
		add_hr
		add_line 

#		tag=type														@items["entity.name.tag"]
#		tag_unknown=tag,bold
#		tag_end=tag,bold
#		attribute=keyword_1												entity.other.attribute-name
#		attribute_unknown=attribute,bold
#		value=string_1													constant.other ?
#		entity=default													@items["entity"]
		
		add_line
		add_comment("Diff")
		add_hr
		add_line 

#		line_added=0xE6E1DC;0x144212
#		line_removed=0xE6E1DC;0x660000
#		line_changed=default
		
	    self.result = @lines.join("\n")		
	    
      end

      protected

      def add_comment(c)
        add_line(format_comment(c))
      end

      def add_hr()
        add_line("#-------------------------------------------------------------------------------")
      end

      def add_line(line="")
        (@lines ||= []) << line
      end

      def format_comment(text)
        "# #{text}"
      end

    end
  end
end
