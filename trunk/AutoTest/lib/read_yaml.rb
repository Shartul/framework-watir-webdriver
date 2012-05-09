#encoding = utf-8
require 'yaml'

class ReadYaml
    
    #功能说明：class：ReadYaml构造函数,在这里初始化了log对象
    #
    #参数说明：
    #file_path:需要读取的yaml路径
    
    def initialize(file_path)
        @file_path = file_path
        self.generate_elements_hash
    end
    
    #功能说明：加载yaml文件,
    
    def load_yaml_file()
        #$log.add_log("begin to load the yaml file where : #{@file_path}")
        file = File.open(@file_path)
        return YAML.load(file)
    rescue
        #$log.add_log($!.to_s)
        Thread.exit
    end
    
    #功能说明：根据element的key获取该元素的上级元素
    #
    #参数说明：
    #element_name：元素名称
    #hash：yaml加载后生成的hash
    
    def get_parents(element_name,hash)
        arr = Array.new
        arr << element_name
        if hash[element_name].has_key?('parent')
            arr << root = hash[element_name]['parent']
            while hash[root].has_key?('parent')
                arr << root = hash[root]['parent']
            end
        end
        return arr
    end
    
    #功能说明：根据element的key获取该元素的属性字符串
    #
    #参数说明：
    #element_name：元素名称
    #hash：yaml加载后生成的hash
    
    def get_element_porperty(element_name,hash)
        p_arr = Array.new
        str = ''
        arr = self.get_parents(element_name,hash)
        for key in arr
            p_arr.clear
            hash[key].each {|k,v|
                if k != 'parent' && k != 'type'
                    p_arr << (k !~ %r{index} && v !~ %r{\/*\/} ? ":#{k}=>\"#{v}\"" : ":#{k}=>#{v}")
                end
            }
            str = ".#{hash[key]['type']}(#{p_arr.join(',')})" +  str 
        end
        return str
    end
    
    #功能说明：生存元素的hash表示：{element_name=>element_porperty}
    
    def generate_elements_hash()
        #$log.add_log('according the yaml file to generate the elements hash')
        hash = load_yaml_file()
        $elements_hash = Hash.new
        hash.keys.each {|k|
            $elements_hash.store(k,self.get_element_porperty(k,hash))
        }
        return $elements_hash
    end
    
    #功能说明：根据element的名称从元素的hash列表中获取属性值
    #
    #参数说明：
    #element_name：元素名称
    
    def get_porperty(element_name)
        if $elements_hash.has_key?(element_name)
            return $elements_hash[element_name]
        else
            #$log.add_log("--ERROR:can not find the element with the element_name : #{element_name}")
        end
    end
end
#
#@element= ReadYaml.new("#{File.dirname(__FILE__)}/../conf/conf.yml")
#puts @element.get_conf

