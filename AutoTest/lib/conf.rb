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
    
    def get_conf(p_key,s_key)
        conf_hash = self.load_yaml_file
        return conf_hash[p_key][s_key]
    end
end