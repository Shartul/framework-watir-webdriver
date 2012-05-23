require 'rubygems'
require 'watir-webdriver'
require 'test/unit'

class Assert
    
    def assert_include?(m,n)
        if eval("m =~ /#{n}/")
            return $tempresult['result'] = 'PASS'
        else
            $tempresult['error'] = "ErrMessage：</br>can not find the expect text:[#{n}] in the current page"
            return $tempresult['result'] = 'FAIL'
        end
    end
    
    def assert_equal?(expect,actual)
        if a == b
            return $tempresult['result'] = 'PASS'
        else
            $tempresult['error'] = "ErrMessage：</br>expected:[#{expect}],actual:[#{actual}]"
            return $tempresult['result'] = 'FAIL'
        end
    end
    
    def assert_exists?(element_name)
        if eval("$browser.find_element(#{element_name}).exists?")
            return $tempresult['result'] = 'PASS'
        else
            $tempresult['error'] = "ErrMessage：</br>can not find the expect text:[#{text}] in the current page"
            return $tempresult['result'] = 'FAIL'
        end
    end
    
    def assert_march?(collection,reg)
        collection.each do |cell|
            if cell =~ reg
                return $tempresult['result'] = 'PASS'
            else
                $tempresult['error'] = "ErrMessage：</br>not all the elements in the #{collection} is march the regular expression ：#{reg}"
                return $tempresult['result'] = 'FAIL'
            end
        end
        
    end
end