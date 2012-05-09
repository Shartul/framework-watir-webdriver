#encoding = utf-8
require "#{File.dirname(__FILE__)}/read_yaml.rb"

class Operate
    
    def initialize(file_path)
        @ui = ReadYaml.new(file_path)
    end
    
    def go_url(url)
        $log.add_log("--open the browser and go to the url:#{url}")
        eval("@browser.goto(#{url})")
    end
    
    #功能说明：根据element的名称定位链接并点击
    #
    #参数说明：
    #element_name：yaml中管理的元素名称
    def click_link(element_name)
        $log.add_log("--click the link with the porperty : #{@ui.find_element(element_name)}")
        eval("@browser#{@ui.find_element(element_name)}.click")
    rescue
        errmsg = "--ERROR:#{$!.to_s} WHERE:#{__FILE__} at line:#{(__LINE__-2).to_s}"
        $log.add_log(errmsg)
    end
    
    #功能说明：根据element的名称定位链接并点击
    #
    #参数说明：
    #element_name：yaml中管理的按钮元素名称
    def click_button(element_name)
        $log.add_log(" click the button with the porperty : #{@ui.find_element(element_name)}")
        eval("@browser#{@ui.find_element(element_name)}.click")
    rescue
        $log.add_log('ERROR:' + $!.to_s)
    end
    
    #功能说明：根据element的名称定位输入框并输入内容
    #
    #参数说明：
    #element_name：yaml中管理的输入框元素名称
    #msg：输入的内容
    def input_msg(element_name,msg)
        $log.add_log("input the message \"#{msg}\" into the text_field : #{@ui.find_element(element_name)}")
        eval("@browser#{@ui.find_element(element_name)}.set('#{msg}')")
    rescue
        $log.add_log('ERROR:' + $!.to_s)
    end
    
    #清除文本框中的内容
    def clear_msg(element_name)
        $log.add_log("clear the message in the text_field : #{@ui.find_element(element_name)}")
        eval("@browser#{@ui.find_element(element_name)}.clear)")
    rescue
        $log.add_log('ERROR:' + $!.to_s)
    end
    
    #点击复选框
    def click_checkbox(element_name)
        $log.add_log("click the checkbox with the porperty : #{@ui.find_element(element_name)}")
        eval("@browser#{@ui.find_element(element_name)}.set)")
    rescue
        $log.add_log('ERROR:' + $!.to_s)
    end
    
    #取消复选框的选中状态
    def clear_checkbox(element_name)
        $log.add_log("clear the checkbox selected with the porperty : #{@ui.find_element(element_name)}")
        eval("@browser#{@ui.find_element(element_name)}.clear)")
    rescue
        $log.add_log('ERROR:' + $!.to_s)
    end
    
    #点击单选框
    def click_radiobox(element_name)
        $log.add_log("click the radiobox with the porperty : #{@ui.find_element(element_name)}")
        eval("@browser#{@ui.find_element(element_name)}.set)")
    rescue
        $log.add_log('ERROR:' + $!.to_s)
    end
    
    #取消单选框的选中状态
    def clear_radiobox(element_name)
        $log.add_log("clear the radiobox selected with the porperty : #{@ui.find_element(element_name)}")
        eval("@browser#{@ui.find_element(element_name)}.clear)")
    rescue
        $log.add_log('ERROR:' + $!.to_s)
    end
end
