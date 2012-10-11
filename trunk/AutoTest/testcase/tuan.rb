#encoding = utf-8
require 'rubygems'
require 'watir-webdriver'
require "#{File.dirname(__FILE__)}/../lib/sys/atm.rb"
require "#{File.dirname(__FILE__)}/../lib/local/local_lib.rb"

class Tuan < ATM
    
    include LocalLib
    BASE_URL = 'http://tuan.qq.com/shanghai'
    
    def test_login
        $browser.goto BASE_URL
        login_in('2427843124','auto@001')
        $assert.assert_include?($browser.text,'退出')
    end
    
    def test_login_out
        $browser.goto BASE_URL
        login_in('2427843124','auto@001')
        $assert.assert_include?($browser.text,'退出')
        login_out()
        $assert.assert_include?($browser.text,'请登录')
    end
    
    def subscibe_email_without_login
        $browser.goto BASE_URL
        $locat.find_element('email_subsrcibe_link').click
        $assert.assert_exists?('login_button')
    end
    
    #从首页入口订阅每日精选和邮件
    def subscibe_email_from_index
        $browser.goto BASE_URL
        login_in('2427843124','auto@001')
        $locat.find_element('email_subsrcibe_link').click
        $locat.wait('pop_subscribe_link')
        $locat.find_element('pop_subscribe_link').click
        $locat.wait('pop_subscribe_success_div')
        $assert.assert_include?($browser.text,'恭喜您订阅成功')
    end
    
    #退订邮件和每日精选
    def unsubscribe_email
        $browser.goto BASE_URL
        login_in('2427843124','auto@001')
        $browser.goto 'http://tuan.qq.com/my/subscribe/'
        sleep 1
        $locat.find_element('my_email_checkbox').click
        sleep 1
        $locat.find_element('my_paipai_checkbox').click
        sleep 1
        $locat.find_element('my_subscribe_link').click
        sleep 1
        $browser.refresh
        sleep 1
        #断言退订后，checkbox是未勾选的class属性：check_btn check_off
        $assert.assert_equal?($locat.find_element('my_email_checkbox').class_name,'check_btn check_off')
    end
    
    #从我的团购入口订阅邮件和每日精选
    def subscibe_email_from_my
        $browser.goto BASE_URL
        login_in('2427843124','auto@001')
        $browser.goto 'http://tuan.qq.com/my/subscribe/'
        sleep 1
        $locat.find_element('my_email_checkbox').click
        sleep 1
        $locat.find_element('my_paipai_checkbox').click
        sleep 1
        $locat.find_element('my_subscribe_link').click
        sleep 1
        $browser.refresh
        sleep 1
        #断言订阅后，checkbox是勾选的class属性：check_btn check_on
        $assert.assert_equal?($locat.find_element('my_email_checkbox').class_name,'check_btn check_on')
        $locat.find_element('my_email_checkbox').click
        sleep 1
        $locat.find_element('my_paipai_checkbox').click
        sleep 1
        $locat.find_element('my_subscribe_link').click
    end
    
    #首页手机团购入口
    def access_the_mobile_page
        $browser.goto BASE_URL
        $locat.find_element('index_qqtuan_mobile_link').click
        $locat.find_element('index_mobile_page_window').use   #切换到新tab页
        $assert.assert_include?($browser.text,'Android')
    end
    
    #首页帮助入口
    def access_the_help_page
        $browser.goto BASE_URL
        $locat.find_element('index_help_link').click
        $locat.find_element('index_help_page_window').use   #切换到新tab页
        $assert.assert_include?($browser.text,'如何团购')
    end
    #精品页前6单随机抽一单访问详情页-通过去看看按钮
    def access_the_detail_page_by_random
        $browser.goto BASE_URL
        $locat.find_element('index_title_link').click
        $locat.find_element('detail_page_window').use
        $assert.assert_include?($browser.text,'特别提醒')
    end
    
    #精品页前6单随机抽一单访问其店铺页
    def access_the_store_page_by_random
        $browser.goto BASE_URL
        $locat.find_element('index_store_link').click
        $locat.find_element('store_page_window').use
        $assert.assert_include?($browser.text,'店铺名')
    end
    
    #精品页前6单随机抽一单访问其退款保障页
    def access_service_index_page_by_random
        $browser.goto BASE_URL
        $locat.find_element('index_service_index_link').click
        $locat.find_element('service_index_page_window').use
        $assert.assert_include?($browser.title,'团购保障')
    end
    
    #检查精品列表页和详情页对应团购价，原价，折扣相等
    def check_price_on_the_index_and_detail_page
        $browser.goto BASE_URL
        div = $locat.find_element('index_detail_divs')   #随机获取一单
        index_price = div.span(:class=>'num_price').text  #获取某资源首页的现价
        index_original_price = div.p(:class=>'original_price').text   #获取某资源首页的原价
        div.link(:class=>'c_tx2').click     #点击title去详情页
        $locat.find_element('detail_page_window').use
        $locat.find_element('index_end_about_tencent_link').focus
        scrollTabBar_price = $locat.find_element('detail_page_scrollTabBar_num_price_span').text    #获取详情页浮层中的价格
        detail_price = $locat.find_element('detail_page_num_price_span').text     #获取某资源详情页的现价
        detail_original_price = $locat.find_element('detail_page_original_price_span').text   #获取某资源详情页的原价
        $assert.assert_equal?(index_original_price, detail_original_price)
        $assert.assert_equal?(index_price, detail_price)  
    end
    
    #检查首页2宫格切换功能
    def change_index_show_style
        $browser.goto BASE_URL
        $locat.find_element('index_show_style_1to2_change_link').click
        if $locat.find_element('index_container_div').class_name == 'grid_c1 re_pos category_01'
            $locat.find_element('index_show_style_2to1_change_link').click
            $assert.assert_equal?($locat.find_element('index_container_div').class_name,'grid_c2b re_pos')
        else
            $assert.assert_equal?($locat.find_element('index_container_div').class_name,'grid_c1 re_pos category_01')
        end
    end
    
    #检查精品首页热门关键词和地区筛选器显示正常
    def check_index_filter_display
        $browser.goto BASE_URL
        key_num = $locat.find_element('index_keybar_p').links.length
        region_num = $locat.find_element('index_areasbar_p').links.length
        $assert.assert_true?(region_num > 1)
        $assert.assert_true?(key_num > 1)
    end
    
    #检查精品首页根据地区筛选器进行筛选
    def index_search_by_region
        $browser.goto BASE_URL
        region_num = $locat.find_element('index_areasbar_p').links.length
        random_region_link = $locat.find_element('index_areasbar_p').link(:index=>rand(region_num-1))
        temp_region_link_id = random_region_link.id
        random_region_link.click
        $locat.find_element('index_region_search_result_window').use
        region_link_class_name = $browser.link(:id=>temp_region_link_id).class_name
        $assert.assert_equal?(region_link_class_name,'current')
    end
    
    #首页左侧导航频道页切换
    def index_channel_change
        $browser.goto BASE_URL
        $locat.find_element('index_life_channel_change_link').click #点击左侧导航生活类目链接
        $assert.assert_exists?('life_service_link') #断言生活服务类目的‘生活服务’链接存在并高亮显示
    end
    
    #首页左侧导航频道页浮层中的二级类目切换
    def index_second_channel_change
        $browser.goto BASE_URL
        $locat.find_element('index_food_channel_link').fire_event('mouseover')  #鼠标移动到美食链接上面弹出浮层
        $locat.wait('index_left_leisure_meals_link')
        $locat.find_element('index_left_leisure_meals_link').click  #点击左侧导航美食浮层中的休闲餐点链接
        $locat.wait('food_channel_leisure_meals_link')
        $assert.assert_exists?('food_channel_leisure_meals_link')   #断言美食频道页‘美食’和‘休闲餐点’链接存在且高亮显示
        $assert.assert_exists?('food_channel_food_link')
    end
    
    #从首页顶部导航访问网购商品类目
    def access_buys_goods_channel
        $browser.goto BASE_URL
        $locat.find_element('index_buys_goods_channel_link').click
        $locat.wait('next_page_link')
        $assert.assert_include?($browser.text,'商品团购')
    end
    
    #从首页顶部导航访问优惠券类目
    def access_coupon_channel
        $browser.goto BASE_URL
        $locat.find_element('index_coupon_channel_link').click
        $locat.wait('coupon_big_item_div')
        $assert.assert_exists?('coupon_big_item_div')
    end
    
end