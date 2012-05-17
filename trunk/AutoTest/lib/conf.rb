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
        method_yaml = self.load_yaml_file
        methods = Array.new
        method_yaml.each do |m|
            if m['run'] == 'Y'
                methods << m['case_name']
            end
        end
        return methods
    end
    
    def get_point(method_name)
        method_yaml = self.load_yaml_file
        method_yaml.each do |m|
            if m['case_name'] == method_name
                return m['point'].to_s
            end
        end
    end
end

method_conf = Conf.new("#{File.dirname(__FILE__)}/../conf/method_conf.yml")
$methods = method_conf.get_methods
