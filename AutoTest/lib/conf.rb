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
         method_hash = self.load_yaml_file
        arr = Array.new
        method_hash.each_key {|key|
            if method_hash[key]['run'] == 'Y'
                arr << key
            end
        }
        puts arr
    end
end
c = Conf.new("#{File.dirname(__FILE__)}/../conf/method_conf.yml")
c.get_methods
