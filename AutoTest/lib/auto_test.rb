#encoding = utf-8
require 'rubygems'
require 'test/unit'
require "#{File.dirname(__FILE__)}/../lib/read_yaml.rb"
require "#{File.dirname(__FILE__)}/../lib/locat.rb"
require "#{File.dirname(__FILE__)}/../lib/conf.rb"
require "#{File.dirname(__FILE__)}/../lib/log.rb"
require "#{File.dirname(__FILE__)}/../lib/report.rb"
require "#{File.dirname(__FILE__)}/../lib/assert.rb"

class AutoTest < Test::Unit::TestCase
    
    def self.startup
        $log = Log.new('ERR')                                                               #创建log对象实例
        $ui= ReadYaml.new("#{File.dirname(__FILE__)}/../elements/elements.yml")             #load元素对象管理的yaml文件
        $conf = Conf.new("#{File.dirname(__FILE__)}/../conf/conf.yml")                      #创建配置文件读取实例
        $locat = Locat.new($ui)                                                             #创建对象定位器实例
        $assert = Assert.new                                                                #创建断言类实例
        $results = Array.new                                                                #测试结果存放数组
        $method_conf = Conf.new("#{File.dirname(__FILE__)}/../conf/method_conf.yml")        #load测试方法配置文件yaml
        $methods = $method_conf.get_methods                                                 #获取需要执行的所有测试方法
        $report = Report.new("report",$conf.get_conf('browser', 'browser'))                 #创建报告实例
    end
    
    def  test_execute
        ObjectSpace.each_object(Class) do |c|
            if c.superclass == AutoTest 
                for method in $methods
                    $tempresult = Hash.new
                    begin
                        $tempresult['point'] = $method_conf.get_point(method)
                        begintime = Time.now                                                #获取case执行的开始时间
                        $browser = eval("Watir::Browser.new :#{$conf.get_conf('browser', 'browser')}")      #创建浏览器对象实例                       
                        c.__send__(method)                                                  #根据获取的case名称，执行case
                        endtime = Time.now                                                  #获取case执行的结束时间
                        $tempresult['runtime'] = (endtime - begintime).to_s + 's'           #计算case执行耗时
                    rescue
                        $tempresult['runtime'] = 'N'                                        #发生异常时将执行时间设置为N
                        $tempresult['result'] = 'FAIL'                                      #发生异常时将执行结果设置为FAIL
                        str = ''
                        for msg in $@                                                       #遍历错误信息数组
                            if msg !~ /test\/unit/                                          #过滤掉test/unit的错误
                                str = str + "</br>#{msg}"                                   #将错误信息拼接成字符串
                            end
                        end
                        $tempresult['error'] = $tempresult['error'] + $!.to_s + "</br>ErrLocation：" + str
                        $log.add_log($!.to_s + ' at ' + $@[0].to_s)
                    end
                    $results << $tempresult
                    $browser.close
                end
            end
        end
    end
    
    def self.shutdown
        $report.createReport($results)                                                       #创建报告
    end
end

