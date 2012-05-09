require 'rubygems'

class LibConfig
    
  def initialize()
    require_file()
    init_class()
  end
  
  def require_file()
    class_file_path = "#{File.dirname(__FILE__)}/../lib"
    file_list = Dir.entries(class_file_path)
    file_list.delete('.')
    file_list.delete('..')
    file_list.each do |file|
      require "#{class_file_path}/#{file}"
    end
  end 
  
  def init_class()
    
    $log = Log.new("AutoTestLog")
    $result = Hash.new
    $ui= Operate.new("#{File.dirname(__FILE__)}/../ui_elements/index.yml")
  end
end
LibConfig.new
