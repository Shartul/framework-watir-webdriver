#encoding = utf-8
require 'rubygems'
require 'watir-webdriver'
require 'test/unit'
require "#{File.dirname(__FILE__)}/../lib/log.rb"
require "#{File.dirname(__FILE__)}/../lib/require_file.rb"

class TuanIndex < AutoTestUnit
    
    def test_login
        $log.add_log("begin to execute the case:#{__method__}")
        @browser.goto 'http://tuan.qq.com'
        $ui.click_link('login_link')
        puts self.exists_text?('城市生活')
    end

end