require 'yaml'
class Conf
    def initialize(file_path)
        @file_path = file_path
    end
    
    def load_yaml_file()
        file = File.open(@file_path)
        return YAML.load(file)
    rescue
        Thread.exit
    end
    
    def get_conf(parent_key,sun_key)
        conf_hash = self.load_yaml_file
        return conf_hash[parent_key][sun_key]
    end
    
    def get_methods
        p method_arr = self.load_yaml_file
#        arr = Array.new
#        for a in method_arr
#            if a['run'] == 'Y'
#                arr << a['case_name']
#            end
#        end
#        puts arr
    end
end
c = Conf.new("#{File.dirname(__FILE__)}/../conf/method_conf.yml")
c.get_methods
