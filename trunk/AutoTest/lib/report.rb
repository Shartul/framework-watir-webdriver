#encoding = utf-8
class Report
    def initialize(reportName,env)
        @head = ''
        @body = ''
        @foot = ''
        @fileName = ''
        @reportName = reportName
        @executeTime = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        @report = ''
        @enviroment = env
    end
    
    def formatReportName(file_path)
        t = Time.now
        y = t.year.to_s
        strMonth = t.month.to_s.length==1? '0'+t.month.to_s : t.month.to_s
        strDay = t.day.to_s.length==1? '0'+t.day.to_s : t.day.to_s
        strHour = t.hour.to_s.length==1? '0'+t.hour.to_s : t.hour.to_s
        strMin = t.min.to_s.length==1? '0'+t.min.to_s : t.min.to_s
        @fileName = file_path + @reportName + y + strMonth + strDay + strHour + strMin + '.html'
        puts @executeTime
        @report = File.open(@fileName,'w')
    end
    
    def reportHead
        @head = "<html>
        <head>
            <meta content=text/html; charset=utf-8 http-equiv=content-type>
            <title>QA Test Report</title>
            <link href='../img/report.css' rel='stylesheet' type='text/css' />
            <script type='text/javascript' src='../img/showLog.js'></script>
        </head>
          <body onload=countNum()>
            <center>
              <table width=800 border=0 cellpadding=2 cellspacing=2>
                  <tr>
                    <td>
                        <table width=100% border=0 cellpadding=2 cellspacing=2>
                          <tr>
                              <td style='width: 150px'><img src='../img/logo.jpg' width=150px height=50px></img></td>
                              <td align=right><p class=title>QA Test Report</p></td>   
                          </tr>
                        </table>
                        
                        <hr width=100% class=border size=1px>
                        
                        <table border=0 width=95% cellpadding=2 cellspacing=2 >
                          <tr>
                              <td width=20%><p class=bold_text>Project  Name</p></td>
                              <td width=5%><p class=bold_text>:</p></td>
                              <td width=75% align=left><p class=bold_text> " + @reportName + "</p></td>
                          </tr>
                          <tr>
                              <td width=20%><p class=bold_text>Test BeginTime</p></td>
                              <td width=5%><p class=bold_text>:</p></td>
                              <td width=75% align=left><p class=bold_text>" + @executeTime + "</p></td>
                          </tr>
                          <tr>
                              <td width=20%><p class=bold_text>Test Enviroment</p></td>
                              <td width=5%><p class=bold_text>:</p></td>
                              <td width=75% align=left><p class=bold_text>" + @enviroment + "</p></td>
                          </tr>
                        </table>
                        
                        </br>
                        
                        <table width=95% cellpadding=2 cellspacing=0>
                            <tr>
                                <td align=right><h5>
                                    <form>
                                    <input type=radio name=result value=all id=all_radio checked=true onclick=selectAll('pass_not_show','fail_not_show','skip_not_show') /><font id=all_count></font>&nbsp
                                    <input type=radio name=result value=pass id=pass_radio onclick=selectPass('pass_not_show','fail_show','skip_show') ><font color=green id=pass_count></font>&nbsp
                                    <input type=radio name=result value=fail id=fail_radio onclick=selectFail('pass_show','fail_not_show','skip_show') /><font color=red id=fail_count></font>&nbsp
                                    <input type=radio name=result value=skip id=skip_radio onclick=selectSkip('pass_show','fail_show','skip_not_show') /><font color=#D26900 id=skip_count></font>
                                    </form>
                                </td></h5>
                            </tr>
                        </table>
                        <center>
                            <table width=95% cellpadding=2 cellspacing=0>
                                <tr>
                                    <th class=bborder_left width=10%><p>Case ID</p></th>
                                    <th class=bborder_left width=68%><p>Test Point</p></th>
                                    <th class=bborder_left width=7%><p>Result</p></th>
                                    <th class=bborder_right width=15%><p>Runtime</th>
                                </tr>"
    end
    
    def reportBody(arr)
        for i in 1..arr.length
            if arr[i-1]['result'] == 'PASS'
                @body = @body +"<tr class='pass_show'>
                    <td class=border_left width=10%><p class=normal_th>" + i.to_s + "</p></td>
                    <td class=border_right width=68%><p id=point_text>" + arr[i-1]['point'] + "</p></td>
                    <td class=border_right width=7%>
                        <div class=a_old>
                            <!-- <p>的id和p下面的div的id要处理成动态的，onclick中传入的参数是动态的 -->
                            <p id=b_" + i.to_s + " class=b_old')><font color=green>PASS</font></p>
                            </div>
                        </div>
                    </td>
                    <td class=border_right width=15%><p class=normal_th>" + arr[i-1]['runtime'] + "</p></td></tr>
                </tr>"
            else if arr[i-1]['result'] == 'FAIL'
                @body = @body +"<tr class='fail_show'>
                    <td class=border_left width=10%><p class=normal_th>" + i.to_s + "</p></td>
                    <td class=border_right width=68%><p id=point_text>" + arr[i-1]['point'] + "</p></td>
                    <td class=border_right width=7%>
                        <div class=a_old>
                            <!-- <p>的id和p下面的div的id要处理成动态的，onclick中传入的参数是动态的 -->
                            <p id=b_" + i.to_s + " class=b_old onclick=getLog('b_" + i.to_s + "','c_" + i.to_s + "')><font class=fail_log>FAIL</font></p>
                            <div id=c_" + i.to_s + " class=c_old load=0>"
                            if arr[i-1]['error'] != nil
                                @body = @body + "<div>errorMsg:" + arr[i-1]['error'] + "</div>"
                            end
                            @body = @body + "</div>
                        </div>
                    </td>
                    <td class=border_right width=15%><p class=normal_th>" + arr[i-1]['runtime'] + "</p></td></tr>
                </tr>"
                else if arr[i-1]['result'] == 'SKIP'
                      @body = @body +"<tr class='skip_show'>
                        <td class=border_left width=10%><p class=normal_th>" + i.to_s + "</p></td>
                        <td class=border_right width=68%><p id=point_text>" + arr[i-1]['point'] + "</p></td>
                        <td class=border_right width=7%>
                            <div class=a_old>
                                <!-- <p>的id和p下面的div的id要处理成动态的，onclick中传入的参数是动态的 -->
                                <p id=b_" + i.to_s + " class=b_old')><font color=#D26900>SKIP</font></p>
                                </div>
                            </div>
                        </td>
                        <td class=border_right width=15%><p class=normal_th>" + arr[i-1]['runtime'] + "</p></td></tr>
                    </tr>"
                end
            end
        end
    end
    end
    
    def reportFoot
        @foot = "<tr>
                                    <td class=bborder_left width=10%><p>&nbsp;</p></td>
                                    <td class=bborder_left width=68%><p>&nbsp;</p></td>
                                    <td class=bborder_left width=7%><p>&nbsp;</p></td>
                                    <td class=bborder_right width=15%><p>&nbsp;</p></td>
                                </tr>
                                
                            </table>
                        </center>
                        </br></br>
                        <hr width=100% class=border size=1px>
                        </br>
                        <center><p class=small_text>Copyright © 1998-2012 Tencent. All Rights Reserved</p></center>
                        <center><p class=small_text>腾讯公司 版权所有</p></center>
                        </br>
                    </td>
                </tr>
              </table>
            </center>
        </body>
    </html>"
    end
    
    def createReport(arr)
        self.formatReportName("#{File.dirname(__FILE__)}/../report/")
        self.reportHead
        self.reportBody(arr)
        self.reportFoot
        htmlReport = @head + @body + @foot
        @report.puts(htmlReport)
    end
    
end
