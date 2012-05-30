module LocalLib
    
    def login_in
        $locat.find_element('login_link').click;
        $locat.find_element('login_username_text_field').set('383145138')
        $locat.find_element('login_password_text_field').set('auto@001') #QQ密码
        $locat.find_element('login_button').click
        $locat.wait('login_out_link')
    end
    
    def login_out
        $locat.find_element('login_out_link').click;
        $locat.wait('login_link')
    end
end