class Log
  
  def initialize(name)
    require "rexml/document"
    @datetime_format  = "%Y-%m-%d %H:%M:%S"
    @log_path         =  "#{File.dirname(__FILE__)}/../../log/"
    self.create_log_file(name)
  end
  
  def create_log_file(fileName)
    date_string = Time.now.strftime("%Y%m%d")
    file_path= "#{File.dirname(__FILE__)}/../../log/"+ fileName + date_string + ".txt"
    @txt_log = File.open(file_path,'w+')
    @txt_log.puts "This log was created at #{Time.now.strftime(@datetime_format)}"
    @txt_log.puts " "
    return file_path
  end
  
  def add_log(message)
    log_time = Time.now.strftime(@datetime_format)
    log_info = log_time+ "  " + message
    @txt_log.puts log_info
end


end
