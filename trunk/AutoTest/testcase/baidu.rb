#encoding = utf-8
require 'yaml'
require 'rubygems'
require 'watir-webdriver'
require "#{File.dirname(__FILE__)}/../lib/auto_test.rb"

class Baidu < AutoTest
    
    def self.baidu_index
        $browser.goto 'http://baidu.com'
        $locat.find_element('zone_link').click
        $assert.assert_include?('更多精彩空间')
    end
#    
#    def self.qq_tuan_index
#        $browser.goto 'http://tuan.qq.com'
#        $assert.assert_include?('城市生活1aaaa')
#    end

#     def self.visit_index
#         $browser.goto 'http://tuan.qq.com'
#         $locat.fine_element('detail_link').click
#         $assert.assert_include?('喜欢')
#     end
    
end