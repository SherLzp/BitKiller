$(function() {
	$('.pop-user-menu').hover(function(){
		$('.login-result-menu').show();
		$(this).addClass('focused');
	},function(){
		$('.login-result-menu').hide();
		$(this).removeClass('focused');

	});
	
	//讨论提问需要实名验证
	$("#is_realname").click(function(){
	
		var url=$(this).attr("burl");
		$.post("/kvideo.php?do=kvideo_discuss&ajax_verify=1",{},function(data){
		
			if('error'==data['flag'])
			{
				is_realname();
			}
			else
			{
				window.location.href=url;
			}
			
		},'json');
			
		
	});
});

function is_realname()
{
	$("body").append($("#mask")).append($("#dialog_confirm"));
	$("#mask,#dialog_confirm").show();
	var dtop=$(window).height()/2-63;
	var dleft=$(window).width()/2-180;
	$(".dialog_cancel").one('click',function(){
		$("#mask,#dialog_confirm").hide();
		$("body").off("keydown");	
	});
	$("#dialog_confirm").css({"top":dtop,"left":dleft});
	
	$("body").on("keydown",function(e){
		
		var ev=window.event || e;
		var code=ev.keyCode||ev.which;
		if(code==13)
		{
			$("#dialog_confirm").trigger("click");
		}
	});
}