#encoding = utf-8
require 'rubygems'
require 'watir-webdriver'
require "#{File.dirname(__FILE__)}/../lib/sys/atm.rb"
require "#{File.dirname(__FILE__)}/../lib/local/local_lib.rb"
class Tuan < ATM
    
    include LocalLib
    BASE_URL = 'http://tuan.qq.com'
    
    def test_login
        $browser.goto BASE_URL
        login_in('383145138','auto@001')
        $assert.assert_include?($browser.text,'退出')
    end
    
    def test_login_out
        $browser.goto BASE_URL
        login_in('383145138','auto@001')
        $assert.assert_include?($browser.text,'退出')
        login_out()
        $assert.assert_include?($browser.text,'请登录')
    end
    
    def subscibe_email_without_login
        $browser.goto BASE_URL
        $locat.find_element('email_subsrcibe_link').click
        $assert.assert_exists?('login_button')
    end
    
    def subscibe_email_from_index
        $browser.goto BASE_URL
        login_in('383145138','auto@001')
        $locat.find_element('email_subsrcibe_link').click
        $locat.wait('pop_subscribe_link')
        $locat.find_element('pop_subscribe_link').click
        $locat.wait('pop_subscribe_success_div')
        $assert.assert_include?($browser.text,'恭喜您订阅成功')
    end
    
    #退订邮件和每日精选
    def unsubscribe_email
        $browser.goto BASE_URL
        login_in('383145138','auto@001')
        $browser.goto BASE_URL+'/my/subscribe/'
        sleep 1
        $locat.find_element('my_email_checkbox').click
        $locat.find_element('my_paipai_checkbox').click
        $locat.find_element('my_subscribe_link').click
        sleep 1
        $browser.refresh
        sleep 1
        #断言退订后，checkbox是未勾选的class属性：check_btn check_off
        $assert.assert_equal?($locat.find_element('my_email_checkbox').class_name,'check_btn check_off')
    end
    
    #从我的团购入口订阅邮件和每日精选
    def subscibe_email_from_my
        $browser.goto BASE_URL
        login_in('383145138','auto@001')
        $browser.goto BASE_URL+'/my/subscribe/'
        sleep 1
        $locat.find_element('my_email_checkbox').click
        $locat.find_element('my_paipai_checkbox').click
        $locat.find_element('my_subscribe_link').click
        sleep 1
        $browser.refresh
        sleep 1
        #断言退订后，checkbox是勾选的class属性：check_btn check_on
        $assert.assert_equal?($locat.find_element('my_email_checkbox').class_name,'check_btn check_on')
        $locat.find_element('my_email_checkbox').click
        $locat.find_element('my_paipai_checkbox').click
        $locat.find_element('my_subscribe_link').click
    end
    
    #首页手机团购入口
    def access_the_mobile_page
        $browser.goto BASE_URL
        $locat.find_element('index_qqtuan_mobile_link').click
        $locat.find_element('index_mobile_page_window').use   #切换到新tab页
        $assert.assert_include?($browser.text,'Android')
    end
    
    #首页帮助入口
    def access_the_help_page
        $browser.goto BASE_URL
        $locat.find_element('index_help_link').click
        $locat.find_element('index_help_page_window').use   #切换到新tab页
        $assert.assert_include?($browser.text,'如何团购')
    end
end