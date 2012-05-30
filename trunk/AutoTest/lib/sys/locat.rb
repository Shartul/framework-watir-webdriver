#encoding = utf-8
require 'rubygems'
require 'watir-webdriver'
require "#{File.dirname(__FILE__)}/read_yaml.rb"
require "#{File.dirname(__FILE__)}/log.rb"

class Locat 
    def initialize(ui)
        @ui = ui
    end
    
    #功能说明：根据element的名称定位元素
    #
    #参数说明：
    #element_name：yaml中管理的元素名称
    def find_element(element_name)
        $log.add_log("locat the element with the porperty:[#{@ui.get_porperty(element_name)}]")
        if eval("$browser#{@ui.get_porperty(element_name)}.exist?")
            return eval("$browser#{@ui.get_porperty(element_name)}")
        else
            $log.add_log "ERROR:can not find the element with the porperty:[#{@ui.get_porperty(element_name)}]"
            return $tempresult['error'] = "ErrMessage：</br>can not find the element with the porperty:[#{@ui.get_porperty(element_name)}]</br>"
        end
    end
    
    def wait(element_name,timeout = 30)
        time = 0
        while(time <= timeout) 
            if eval("$browser#{@ui.get_porperty(element_name)}.exist?")
                break
            else
                sleep 1
                time = time + 1 
                if (time == timeout)
                    $log.add_log "ErrMessage：#{time}s passed,the element[#{@ui.get_porperty(element_name)}] was not appear on current page"
                end
            end
        end
    end
end
