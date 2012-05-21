#encoding = utf-8
require 'rubygems'
require "#{File.dirname(__FILE__)}/../lib/read_yaml.rb"
require "#{File.dirname(__FILE__)}/../lib/locat.rb"
require "#{File.dirname(__FILE__)}/../lib/conf.rb"
require "#{File.dirname(__FILE__)}/../lib/log.rb"
require "#{File.dirname(__FILE__)}/../lib/report.rb"
require "#{File.dirname(__FILE__)}/../lib/assert.rb"

class AutoTest 
    
    #运行于每个测试类之前
    def before_test
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
    
    #运行于每个测试方法之前
    def before_method(method)
        $tempresult = Hash.new
        $begintime = Time.now                                                #获取case执行的开始时间
        $tempresult['point'] = $method_conf.get_point(method)
        $browser = eval("Watir::Browser.new :#{$conf.get_conf('browser', 'browser')}")      #创建浏览器对象实例  
    end
    
    #运行于每个测试方法之后
    def after_method
        $endtime = Time.now                                                  #获取case执行的结束时间
        $tempresult['runtime'] = ($endtime - $begintime).to_s + 's'           #计算case执行耗时
        $browser.close
    end
    
    #运行与每个测试方法之后
    def after_test
        $report.createReport($results)                                                       #创建报告
    end
    
    #发生异常时，该方法被调用
    def when_expection_do
        $tempresult['runtime'] = 'N'                                        #发生异常时将执行时间设置为N
        $tempresult['result'] = 'FAIL'                                      #发生异常时将执行结果设置为FAIL
        str = ''
        for msg in $@                                                       #遍历错误信息数组
            if msg !~ /test\/unit/                                          #过滤掉test/unit的错误
                str = str + "</br>#{msg}"                                   #将错误信息拼接成字符串
            end
        end
        errmsg = $!.to_s.sub('<','&lt').sub('>','&gt')
        $tempresult['error'] = $tempresult['error'] != nil ? ($tempresult['error'] + errmsg + "</br>ErrLocation：" + str) : ("ErrMessage：</br>" + $!.to_s + "</br>ErrLocation：" + str)
        $log.add_log($!.to_s + ' at ' + $@[0].to_s)
        $browser.close                                                      #发生异常时，关闭浏览器
    end
end

at_exit do
    ObjectSpace.each_object(Class) do |c|
        if c.superclass == AutoTest
            AutoTest.new.before_test()                                      
            for method in $methods
                begin
                    AutoTest.new.before_method(method)
                    c.__send__(method)                                       #根据获取的case名称，执行case
                    AutoTest.new.after_method
                rescue
                    AutoTest.new.when_expection_do
                end
                $results << $tempresult
            end
            AutoTest.new.after_test()
        end
    end
end

