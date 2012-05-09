#encoding = utf-8
require 'rubygems'
require 'watir-webdriver'
require 'test/unit'
require "#{File.dirname(__FILE__)}/../lib/read_yaml.rb"
require "#{File.dirname(__FILE__)}/../lib/locat.rb"
require "#{File.dirname(__FILE__)}/../lib/conf.rb"


class AutoTest < Test::Unit::TestCase
    
    def self.startup
        $ui= ReadYaml.new("#{File.dirname(__FILE__)}/../elements/index.yml")
        $conf = Conf.new("#{File.dirname(__FILE__)}/../conf/conf.yml")
        $browser = eval("Watir::Browser.new :#{$conf.get_conf('browser', 'browser')}")
        $locat = Locat.new($ui)
    end
end