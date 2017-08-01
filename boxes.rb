def collapse(str)
  str.strip.gsub(/\s+/, " ")
end

# first need a function that can return a list of words
def tokenize(str)
  collapse(str).split ' '
end

def max_length(arr)
  max_length = 0
  for str in arr
    if str.length > max_length
      max_length = str.length
    end
  end
  max_length
end

def middle_box(str, line_limit = 80, border_options = {lead: "|", trail: "|"})

  lead = border_options[:lead]
  trail = border_options[:trail]

  tokens = tokenize str
  max_size = max_length tokens
  if max_size + 2 > line_limit
    line_limit = max_size + 2
  end
  char_count = 2
  output = lead
  idx = 0

  while idx < tokens.length
    word = tokens[idx]
    word_length = word.length
    char_count += word_length

    if char_count > line_limit
      spaces = line_limit - (char_count - word_length)
      spaces = " " * spaces
      output += spaces + trail
      output += "\n" + lead
      char_count = 2 + word_length
    end

    output += word + " "
    char_count += 1

    if char_count > line_limit
      output.chop!
      char_count -= 1
    end

    idx += 1

  end

  spaces = line_limit - char_count
  spaces = " " * spaces
  output + spaces + trail
end

def border(lead = "+", trail = "+", border = "-", line_limit = 80)
  lead + (border * (line_limit - 2)) + trail
end

def pretty_print(str, border_options = {top: {lead: "+", trail: "+", border: "-"}, bottom: {lead: "+", trail: "+", border: "-"}, middle: {lead: "|", trail: "|"}}, line_limit = 80)
  output = ""
  middle = ""
  tokens = tokenize str
  max_size = max_length tokens
  if max_size + 2 > line_limit
    line_limit = max_size + 2
  end

  if !border_options.nil?
    if border_options[:middle]
      middle = middle_box(str, line_limit, border_options[:middle])
    else
      middle = middle_box(str, line_limit)
    end
  else
    middle = middle_box(str, line_limit)
  end

  if !border_options.nil?
    if border_options[:top]
      options = border_options[:top]
      lead = options[:lead]
      trail = options[:trail]
      border = options[:border]
      top_border = border(lead, trail, border, line_limit)
      output += top_border + "\n"
    end

    output += middle

    if border_options[:bottom]
      output += "\n"
      options = border_options[:bottom]
      lead = options[:lead]
      trail = options[:trail]
      border = options[:border]
      bottom_border = border(lead, trail, border, line_limit)
      output += bottom_border
    end
  else
    output += middle
  end
  output
end
