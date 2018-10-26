/*页面顶部通知区域用js
 *
*/

function load_header_notice()
{
	$(".notice_header ul").html('');
	$.post("/api/get_note_list.php?page=1&page_size=5&type=new",{},function(data){
		
		if(1==data['flag'])
		{
			if(0!=parseInt(data['msg']['newcount']))
			{
				$(".home-unread-count").html(data['msg']['newcount']).show();
			}
			else
			{
				$(".home-unread-count").html(0);
				$(".notice_header").html("暂无未读");
                $(".notice_header").css({"height":"60px","line-height":"40px"});
                $(".all_read_set").hide();
			}
			for(var i=0;i<data['msg']['list'].length;i++)
			{
				/**if(data['msg']['list'][i]['note'].indexOf('道具')>=0)
				continue;**/
				var ot=$('<li class="clearfix" onclick="goto_notice()"><span class="bcircle"></span> <div class="bname">姓名fef </div><div class="btime">2015-12-14 12:23:00</div><div class="binfo">jofeof全部设为已读全部设为已读全部设为已读</div></li>').clone(true);
				ot.find(".bname").attr("title",data['msg']['list'][i]['real_name']).html(cutstr(data['msg']['list'][i]['real_name'],12));
				ot.find(".btime").html(data['msg']['list'][i]['date_format']);
				ot.find(".binfo").attr("title",data['msg']['list'][i]['note']).html(cutstr(data['msg']['list'][i]['note'],55));

				if(parseInt(data['msg']['list'][i]['new'])==1)
				{

					$(".notice_header ul").append(ot);
				//	ot.find(".bcircle").removeClass('bcircle').addClass('bcircle_read');
				}
				//$(".notice_header ul").append(ot);

			}
		}
		
	},'json');
}
function goto_notice()
{
	window.location.href="/space.php?do=notice&is_read=no";
}
function all_read_set()
{
	$.post("/space.php?do=notice&ignore=1&ajax=1",{},function(data){
		
		if(1==data['flag'])
		{
			load_header_notice();
			window.location.reload(true);
		}
		
	},'json');
}

function cutstr(str,len)  
{  
   var str_length = 0;  
   var str_len = 0;  
      str_cut = new String();  
      str_len = str.length;  
      for(var i = 0;i<str_len;i++)  
     {  
        a = str.charAt(i);  
        str_length++;  
        if(escape(a).length > 4)  
        {  
         //中文字符的长度经编码之后大于4  
         str_length++;  
         }  
         str_cut = str_cut.concat(a);  
         if(str_length>=len)  
         {  
         str_cut = str_cut.concat("...");  
         return str_cut;  
         }  
    }  
    //如果给定字符串小于指定长度，则返回源字符串；  
    if(str_length<len){  
     return  str;  
    }
}
$(function(){
	//头像连接后加时间戳
	(function (){
		var timenow = new Date().getTime();
		var str = document.getElementById('head-pho').src;
		document.getElementById('head-pho').src=str+"?d="+timenow;
	})()
})