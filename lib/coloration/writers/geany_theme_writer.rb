module Coloration
  module Writers
    module GeanyThemeWriter

      def build_result

	################################################################
	########################## Mapping #############################
	################################################################

        mapping = Hash.new
	
        mapping["generic"] = {
        
          # This is the default style. It is used for styling files without a filetype set.
          "default"                 => [ @ui["foreground"].to_hex, @ui["background"].to_hex, "false", "false" ],
          "error"                   => @items["invalid"] || ""

        }
        
        mapping["editor_styles"] = {
          
          # 3rd selection argument is true to override default foreground
          # 4th selection argument is true to override default background
          "selection"               => [ "", @ui["selection"], "", override("selection") ],
          
          
          # The style for coloring the background of the current line. 
          # Only the second and third arguments are interpreted. 
          # The second argument is the background color. 
          # Use the third argument to enable or disable background highlighting 
          # for the current line (has to be true/false).
          # marker line????????????????????????????????????????????????/
          "current_line"            => [ "", @ui["lineHighlight"], override("lineHighlight"), "" ],
          
          "brace_good"              => "",
          "brace_bad"               => "",
          "margin_line_number"      => "",
          "margin_folding"          => "",
          "fold_symbol_highlight"   => (@ui["background"].to_hex || ""),
          "indent_guide"            => "",
          
          # colour of the caret(the blinking cursor), only first and third argument is interpreted
          # set the third argument to true to change the caret into a block caret
          "caret"                   => [ @ui["caret"], "", "false" ],
          
          # The style for coloring the white space if it is shown. 
          # The first both arguments define the foreground and background colors, 
          # the third argument sets whether to use the defined foreground color 
          # or to use the color defined by each filetype for the white space. 
          # The fourth argument defines whether to use the background color.
          "white_space"             => [ @ui["invisibles"], "", override("invisibles"), "" ],
          
          "marker_line"             => (@ui["invisibles"].to_hex || ""),
          "marker_search"           => (@ui["invisibles"].to_hex || ""),
          "marker_mark"             => (@ui["invisibles"].to_hex || ""),
          
        }
      
        mapping["programming_languages"] = {

          "comment"                 => @items["comment"] || "",
          "comment_doc"             => "comment",
          "comment_line"            => "comment",
          "comment_line_doc"        => "comment_doc",
          "comment_doc_keyword"     => "comment_doc,bold",
          "comment_doc_keyword_error" => "comment_doc,italic",

          "number"                  => @items["constant.numeric"] || "",
          "number_1"                => "number",
          "number_2"                => "number_1",

          "type"                    => @items["entity.name.type"] || "",
          "class"                   => @items["entity.name.class"] || "type",
          "function"                => @items["entity.name.function"] || "",
          "parameter"               => @items["variable.parameter"] || "function",

          "keyword"                 => @items["keyword.control"] || @items["keyword"] || "",
          "keyword_1"               => @items["keyword"] || "keyword",
          "keyword_2"               => @items["support.function"] || "keyword_1",
          "keyword_3"               => @items["constant.language"] || "keyword_1",
          "keyword_4"               => @items["variable.other"] || "keyword_1",

          "identifier"              => "default",
         # "identifier"              => @items["storage.type"] || "default",
          "identifier_1"            => "identifier",
          "identifier_2"            => "identifier_1",
          "identifier_3"            => "identifier_1",
          "identifier_4"            => "identifier_1",

          "string"                  => @items["string,string.quoted"] || "",
          "string_1"                => "string",
          "string_2"                => "string_1",
          "string_eol"              => "string_1,italic",
          "character"               => @items["constant.character"] || "string_1",
          "backtick"                => "string_2",
          "here_doc"                => "string_2",
          
          "label"                   => @items["constant.other.symbol"] || "default,bold",
          "preprocessor"            => @items["other.preprocessor"] || @items["keyword.other"] || "",
          "regex"                   => @items["string.regexp"] || "number_1",
          "operator"                => @items["keyword.operator"] || "default",
          "decorator"               => "string_1,bold",
          "other"                   => "default",

        }

        mapping["markup_languages"] = {  
        
          "tag"                     => @items["entity.name.tag"] || @items["meta.tag"] || "type",
          "tag_unknown"             => "tag,bold",
          "tag_end"                 => "tag,bold",
          "attribute"               => @items["entity.other.attribute-name"] || "keyword_1",
          "attribute_unknown"       => "attribute,bold",
          "value"                   => @items["constant.other"] || "string_1",
          "entity"                  => @items["entity"] || "",
          
        }

        mapping["diff"] = {  
        
          "line_added"              => "",
          "line_removed"            => "error",
          "line_changed"            => "",
          
        }
        
	################################################################
	########################## Writing #############################
	################################################################
	      
        # [theme_info] #################################################
        
        add_line("[theme_info]")
        add_line("name=#{name}")
        add_line("description=")
        add_line("version=")
        add_line("author=")
        add_line("url=")
        
        # [named_styles] ###############################################
        
        add_line    
        add_line("[named_styles]")
        add_line
	add_section(mapping["generic"])
        
        # Editor styles ################################################
        
        add_line
        add_comment("Editor styles")
        add_hr
        add_line
        add_section(mapping["editor_styles"])
        
        # Programming languages ########################################
        
        add_line
        add_comment("Programming languages")
        add_hr
        add_line 
        add_section(mapping["programming_languages"])
             
        # Markup languages #############################################

        add_line
        add_comment("Markup-type languages")
        add_hr
        add_line 
        add_section(mapping["markup_languages"])
        
        # Diff #########################################################
        
        add_line
        add_comment("Diff")
        add_hr
        add_line 
	add_section(mapping["diff"])
	
        self.result = @lines.join("\n")        
        
      end

      protected

      def override(name)
        (@ui.has_key?(name)) ? true : false
      end

      def add_comment(c)
        add_line(format_comment(c))
      end
    
      def add_hr()
        add_line("#-------------------------------------------------------------------------------")
      end

      def add_line(line="")
        (@lines ||= []) << line
      end

      def add_section(section)
        section.each do |name, tuple|
          add_line(format_tuple(name, tuple))
        end
      end
      
      def format_tuple(name, tuple)        
	if tuple.is_a?(Style) 
	  tuple = [ tuple.foreground, tuple.background, tuple.bold, tuple.italic ]
	end
	
        case tuple
          when Array
            tuple.collect! do |value|
              case value
                when Color::RGB
                  value.to_hex
                else
                  value.to_s
              end
            end
            # add name= and values separated by ';', then cut not necessary ';' from the end of line
            return "#{name}=#{tuple.join(';').gsub(/;*$/, '')}"
          else
            return "#{name}=#{tuple}"
        end
      end

      def format_comment(text)
        "# #{text}"
      end

    end
  end
end
