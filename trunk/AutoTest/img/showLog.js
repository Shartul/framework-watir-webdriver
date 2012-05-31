/**
 * @author autowang
 */
function getLog(pId, divId){

    var div = document.getElementById(divId);
    var p = document.getElementById(pId);
    if (div.className == "c_old") {
        div.className = "c_new"
        p.className = "b_new";
    }
    else {
        div.className = "c_old"
        p.className = "b_old";
    }
}


function selectAll(passName, failName, skipName){
    var pass = document.getElementsByClassName(passName);
    var fail = document.getElementsByClassName(failName);
    var skip = document.getElementsByClassName(skipName);
    if (fail.length != 0) {
        for (var j = 0; j <= fail.length; j++) {
			j = 0;
            fail[0].className = "fail_show";
        }
    }
    if (skip.length != 0) {
        for (var k = 0; k <= skip.length; k++) {
			k = 0;
            skip[0].className = "skip_show";
        }
    }
    if (pass.length != 0) {
        for (var i = 0; i <= pass.length; i++) {
			i = 0;
            pass[0].className = "pass_show";
        }
    }
    
    
    
}

function selectPass(passName, failName, skipName){
    var pass = document.getElementsByClassName(passName);
    var fail = document.getElementsByClassName(failName);
    var skip = document.getElementsByClassName(skipName);
    if (fail.length != 0) {
        for (var i = 0; i <= fail.length; i++) {
			i = 0;
            fail[0].className = "fail_not_show";
        }
    }
    if (skip.length != 0) {
        for (var j = 0; j <= skip.length; j++) {
			j = 0;
            skip[0].className = "skip_not_show";
        }
    }
    if (pass.length != 0) {
        for (var k = 0; k <= pass.length; k++) {
			k = 0;
            pass[0].className = "pass_show";
        }
    }
    
}

function selectFail(passName, failName, skipName){
    var pass = document.getElementsByClassName(passName);
    var fail = document.getElementsByClassName(failName);
    var skip = document.getElementsByClassName(skipName);
    if (fail.length != 0) {
        for (var k = 0; k <= fail.length; k++) {
			k = 0;
            fail[0].className = "fail_show";
        }
    }
    if (skip.length != 0) {
        for (var j = 0; j <= skip.length; j++) {
			j = 0;
            skip[0].className = "skip_not_show";
        }
    }
    if (pass.length != 0) {
        for (var i = 0; i <= pass.length; i++) {
			i = 0;
            pass[0].className = "pass_not_show";
        }
    }
}

function selectSkip(passName, failName, skipName){
    var pass = document.getElementsByClassName(passName);
    var fail = document.getElementsByClassName(failName);
    var skip = document.getElementsByClassName(skipName);
    if (fail.length != 0) {
        for (var j = 0; j <= fail.length; j++) {
			j = 0;
            fail[0].className = "fail_not_show";
        }
    }
    if (skip.length != 0) {
        for (var k = 0; k <= skip.length; k++) {
			k = 0;
            skip[0].className = "skip_show";
        }
    }
    if (pass.length != 0) {
        for (var i = 0; i <= pass.length; i++) {
			i = 0;
            pass[0].className = "pass_not_show";
        }
    }
    
}

function countNum(){
    var pass = document.getElementsByClassName('pass_show');
    var notPass = document.getElementsByClassName('pass_not_show');
    passTotal = pass.length + notPass.length;
    document.getElementById("pass_count").innerHTML = 'PASS(' + passTotal + ')';
    
    var fail = document.getElementsByClassName('fail_show');
    var notFail = document.getElementsByClassName('fail_not_show');
    failTotal = fail.length + notFail.length;
    document.getElementById("fail_count").innerHTML = 'FAIL(' + failTotal + ')';
    
    var skip = document.getElementsByClassName('skip_show');
    var notskip = document.getElementsByClassName('skip_not_show');
    skipTotal = skip.length + notskip.length;
    document.getElementById("skip_count").innerHTML = 'SKIP(' + skipTotal + ')';
	
	allTotal = passTotal + failTotal + skipTotal;
	
	document.getElementById("all_count").innerHTML = 'ALL(' + allTotal + ')';
}
