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
        login_in()
        $assert.assert_include?($browser.text,'退出')
    end
    
    def test_login_out
        $browser.goto BASE_URL
        login_in()
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
        login_in()
        $locat.find_element('email_subsrcibe_link').click
        $locat.wait('pop_subscribe_link')
        $locat.find_element('pop_subscribe_link').click
        $locat.wait('pop_subscribe_success_div')
        $assert.assert_include?($browser.text,'恭喜您订阅成功')
    end
    
    def unsubscribe_email
        $browser.goto BASE_URL
        login_in()
        $browser.goto BASE_URL+'/my/subscribe/'
        $locat.find_element('my_email_checkbox').click
        $locat.find_element('my_paipai_checkbox').click
        $locat.find_element('my_subscribe_link').click
        $browser.refresh
        #断言退订后，checkbox是未勾选的class属性：check_btn check_off
        $assert.assert_equal?($locat.find_element('my_email_checkbox').class_name,'check_btn check_off')
    end
    
    def subscibe_email_from_my
        $browser.goto BASE_URL
        login_in()
        $browser.goto BASE_URL+'/my/subscribe/'
        $locat.find_element('my_email_checkbox').click
        $locat.find_element('my_paipai_checkbox').click
        $locat.find_element('my_subscribe_link').click
        sleep 1
        $browser.refresh
        sleep 1
        #断言退订后，checkbox是勾选的class属性：check_btn check_on
        $assert.assert_equal?($locat.find_element('my_email_checkbox').class_name,'check_btn check_on')
    end
end