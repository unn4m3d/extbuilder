require "option_parser"
require "file_utils"

PRELUDE = "#{__DIR__}/extb_ext.cr"
TMP = "/tmp/extbuilder-#{Time.now.epoch_ms}"
Dir.mkdir TMP

def ecmd(str)
  unless system "#{str} > #{TMP}/stdout.log 2> #{TMP}/stderr.log"
    puts "EXTBUILDER : #{str} failed"
    exit 2
  end
end

def build(i, o, s)
  namet = s ? "**/*.a" : "**/*.so"
  o = File.expand_path o
  Dir.mkdir_p o
  files = [] of String
  Dir.cd i do
    if File.exists? "Extfile"
      fmt = s ? "static" : "shared"
      ecmd "crystal run Extfile --prelude \"#{PRELUDE}\" -- --output #{o} --format #{fmt}"
      files = File.read(File.join(TMP,"stderr.log")).split("\n")
    elsif File.exists? "CMakeLists.txt"
      Dir.mkdir "build" unless File.exists? "build"
      Dir.cd "build" do
        ecmd "cmake .."
        ecmd "make"
        Dir.glob namet do |f|
          files << File.basename f
          FileUtils.cp f, o
        end
      end
    elsif File.exists?("Makefile") || File.exists?("./configure")
      ecmd "./configure" if File.exists? "./configure"
      ecmd "make"
      Dir.glob namet do |f|
        files << File.basename f
        FileUtils.cp f, o
      end
    else
      puts "EXTBUILDER : Cannot found recipe for #{i}"
      exit 1
    end
  end
  flist = if s
    files.map{ |x| File.join(o, x) }.join(" ")
  else
    files.map do |file|
      file.scan(/lib(?<name>.*)\.so/).map{ |m| "-l#{m["name"]}" }.first
    end.join(" ") + " -L#{o}"
  end
  puts %(@[Link(ldflags: "#{flist}")])
end

static = false

OptionParser.parse! do |opt|
  opt.on("-s","--static","Make static libs") do
    static = true
  end
end

input, output = ARGV

build input, output, static
