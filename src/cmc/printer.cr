require "terminal_table"

module CMC
  def print_header(header_status : String, header_time : String, width : Int8)
    puts "\n\
      #{ repeat('=', width) }\n\
      #{ space_between(header_status, header_time, width) }\n\
      #{ repeat('=', width) }\n\n"
  end


  def space_between(left_string : String, right_string : String, width : Int8)
    string_space_between = String::Builder.new width
    string_space_between << left_string

    inner_padding = width - left_string.size - right_string.size
    (1..inner_padding).each { string_space_between << " " }

    string_space_between << right_string

    string_space_between.to_s
  end


  def repeat(repeating_char : Char, width : Int8)
    repeat = String::Builder.new width
    (1..width).each { repeat << repeating_char.to_s }
    repeat.to_s
  end


  def print_table(headings : Array(String), tokens : Array(Array(String)))
    table = TerminalTable.new
    table.headings = headings

    tokens.each do |token_info|
      table << token_info
    end

    puts table.render
  end
end
