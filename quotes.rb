require 'yaml'
require_relative 'boxes.rb'

# you can extend ruby's provided classes
# got this from stackoverflow
# https://stackoverflow.com/questions/1489183/colorized-ruby-output
class String
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def gray;           "\e[37m#{self}\e[0m" end

  def bg_black;       "\e[40m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_brown;       "\e[43m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_gray;        "\e[47m#{self}\e[0m" end

  def bold;           "\e[1m#{self}\e[22m" end
  def italic;         "\e[3m#{self}\e[23m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def blink;          "\e[5m#{self}\e[25m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end

def readText(file)
  text = ""
  File.open(file, "r") do |f|
    f.each_line do |line|
      text += line
    end
  end
  text
end

def help
  "usage: quotes [columns] [path_to_file]"
end

def print_quote(author, quote, cols = 80)

  top_border_options = {lead: "/", trail: "\\", border: "="}
  bottom_border_options = {lead: "\\", trail: "/", border: "="}
  border_options = {top: top_border_options}

  quote_part = pretty_print quote, border_options, cols

  author = "--" + author

  author_part = "\n" + (pretty_print "", nil, cols)
  author_part += "\n" + (pretty_print author, {bottom: bottom_border_options}, cols)
  quote_part + author_part
end

# check to see if any command line arguments are supplied to the
# program
if ARGV.length == 1
  text = readText "quotes.yaml"
  yaml = YAML.load text

  # select a random author
  author = yaml.keys[rand(0...yaml.keys.length)]
  quote = yaml[author][rand(0...yaml[author].length)]
  puts (print_quote author, quote, ARGV[0].to_i).bold.magenta.bg_black
else
  puts help
end
