#encoding = utf-8
require 'rubygems'
require 'watir-webdriver'
require 'test/unit'
#require "#{File.dirname(__FILE__)}/../lib/read_yaml.rb"
#require "#{File.dirname(__FILE__)}/../lib/locat.rb"
require "#{File.dirname(__FILE__)}/../lib/conf.rb"
#require "#{File.dirname(__FILE__)}/../lib/log.rb"

class AutoTest < Test::Unit::TestCase
    
    
#        def self.startup
#            $log = Log.new('ERR')
#            $ui= ReadYaml.new("#{File.dirname(__FILE__)}/../elements/index.yml")
#            $conf = Conf.new("#{File.dirname(__FILE__)}/../conf/conf.yml")
#            $browser = eval("Watir::Browser.new :#{$conf.get_conf('browser', 'browser')}")
#            $locat = Locat.new($ui)
#        end

    def  test_execute
        ObjectSpace.each_object(Class) do |c|
            if c.superclass == AutoTest 
                arr = %W[a_1 a_2]
                for method in arr
                    begin
                        c.__send__(method)
                    rescue
                        puts "error"
                        p $!
                    end
                end

            end
        end
    end
end

