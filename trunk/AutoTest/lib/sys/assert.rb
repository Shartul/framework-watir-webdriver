require 'rubygems'

class Assert
    
    def assert_include?(m,n)
        if m =~ /#{n}/
            return $tempresult['result'] = 'PASS'
        else
            $tempresult['error'] = "ErrMessage：</br>can not find the expect text:[#{n}] in the current page"
            $log.add_log($tempresult['error'])
            return $tempresult['result'] = 'FAIL'
        end
    end
    
    def assert_true?(express)
        if express
            return $tempresult['result'] = 'PASS'
        else
            $tempresult['error'] = "ErrMessage：</br>the express is false"
            $log.add_log($tempresult['error'])
            return $tempresult['result'] = 'FAIL'
        end
    end
    
    def assert_equal?(expect,actual)
        if expect == actual
            return $tempresult['result'] = 'PASS'
        else
            $tempresult['error'] = "ErrMessage：</br>expected:[#{actual}],actual:[#{expect}]"
            $log.add_log($tempresult['error'])
            return $tempresult['result'] = 'FAIL'
        end
    end
    
    def assert_exists?(element_name)
        if $locat.find_element('#{element_name}').exists?
            return $tempresult['result'] = 'PASS'
        else
            $tempresult['error'] = "ErrMessage：</br>can not find the expect element:[#{element_name}] in the current page"
            $log.add_log($tempresult['error'])
            return $tempresult['result'] = 'FAIL'
        end
    end
    
    def assert_march?(collection,reg)
        collection.each do |cell|
            if cell =~ reg
                return $tempresult['result'] = 'PASS'
            else
                $tempresult['error'] = "ErrMessage：</br>not all the elements in the #{collection} is march the regular expression ：#{reg}"
                $log.add_log($tempresult['error'])
                return $tempresult['result'] = 'FAIL'
            end
        end
    end
end