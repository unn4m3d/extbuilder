require "prelude"
require "option_parser"
# TODO : Useful functions for Extfiles

module ExtBuilder
  class_property format = :static
  class_property output = ""
end

OptionParser.parse! do |o|
  o.on("-oDIR","--output=DIR","Set out dir") do |dir|
    ExtBuilder.output = dir
  end

  o.on("-fFMT","--format=FMT","Set format") do |format|
    ExtBuilder.format = format == "shared" ? :shared : :static
  end
end

unless File.exists? ExtBuilder.output
  Dir.mkdir_p ExtBuilder.output
end
