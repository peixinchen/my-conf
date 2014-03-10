require 'rubygems'  
#require 'map_by_method'  
require 'what_methods'  
require 'wirble'  
require 'irb/completion'  

IRB.conf[:AUTO_INDENT]=true
IRB.conf[:INSPECT_MODE]=false

class Regexp  
  def show(a)  
    a =~ self ? "#{$`}<<#{$&}>>#{$'}" : "no match"  
  end  
end  
  
Wirble.init  
Wirble.colorize

