module LocalLib
    
    def login_in(user,psw)
        $locat.find_element('login_link').click;
        $locat.find_element('login_username_text_field').set(user)
        $locat.find_element('login_password_text_field').set(psw) #QQ密码
        $locat.find_element('login_button').click
        $locat.wait('login_out_link')
    end
    
    def login_out
        $locat.find_element('login_out_link').click;
        $locat.wait('login_link')
    end
    
end