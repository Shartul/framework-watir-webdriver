#encoding = utf-8
require 'rubygems'
require 'watir-webdriver'
require "#{File.dirname(__FILE__)}/../lib/auto_test.rb"
class Tuan < AutoTest
    def login
        $browser.goto 'http://tuan.qq.com'
        $locat.find_element('login_link').click;
        $locat.find_element('login_username').set('383145138')
        $locat.find_element('login_password').set('xxx') #QQ密码
        $locat.find_element('login_button').click
        $locat.wait('login_out')
        $assert.assert_include?($browser.text,'退出')
    end
    
    def city_life
        $browser.goto 'http://tuan.qq.com'
        $locat.find_element('shop_on_line_goods').click
        $assert.assert_include?($browser.url,'channelid=14')
    end
end