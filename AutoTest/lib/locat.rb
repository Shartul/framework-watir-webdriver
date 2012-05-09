#encoding = utf-8
require 'rubygems'
require 'watir-webdriver'
require 'test/unit'
require "#{File.dirname(__FILE__)}/read_yaml.rb"
require "#{File.dirname(__FILE__)}/log.rb"

class Locat 
    def initialize(ui,browser)
        @ui = ui
    end
    
    #功能说明：根据element的名称定位元素
    #
    #参数说明：
    #element_name：yaml中管理的元素名称
    def find_element(element_name)
        if eval("$browser#{@ui.get_porperty(element_name)}.exist?")
           p "$browser#{@ui.get_porperty(element_name)}"
            return eval("$browser#{@ui.get_porperty(element_name)}")
        else
            puts "ERROR:can not find the element with the porperty:#{@ui.get_porperty(element_name)}"
            #$log.add_log("ERROR:can not locat the link with the porperty:#{@ui.get_porperty(element_name)}")
        end
    end
end
