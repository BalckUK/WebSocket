<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	$(function() {
		var ws = new WebSocket("ws://118.32.103.176//chat");

		ws.onmessage = function(e) {
			var text = e.data;
			var span = $("<span id=other></span>")
			var div = $("<div></div>");
			span.append(text);
			div.append(span);
			$("#message").append(div);
			$("#message").scrollTop($("#message")[0].scrollHeight);
		}

		$("#text").keydown(function(e) {
			if (e.keyCode == 13) {
				e.preventDefault();
				var text = $("#text").html();
				var span = $("<span id=me></span>")
				var div = $("<div></div>");
				if ($.trim(text) == "" || text == null) {
				} else {
					span.append(text);
					div.append(span);
					$("#message").append(div);
					$("#text").html("");
					ws.send(text);
					$("#message").scrollTop($("#message")[0].scrollHeight);
				}
			}
		})
		
		$("#embtn").on("click",function(){
			$("#emobox").slideDown(1500);
		})
		$("#close").on("click",function(){
			$("#emobox").slideUp(1500);
		})
		$("#motion>img").on("click",function(){
			$("#text").append($(this).clone());
		})
		
	})
</script>
<style>
* {
	box-sizing: border-box;
	padding: 0px;
}

#web {
	width: 600px;
	height: 800px;
	position: relative;
}

#message {
	width: 100%;
	height: 90%;
	border: 1px solid black;
	overflow-y: auto;
	word-wrap: break-word;
	word-break: break-all;
	background-color: #00FFFF;
}
#textbox{
	width: 100%;
	height: 10%;
	position: relative;
}

#text {
	width: 80%;
	height: 100%;
	float: left;
	border: 1px solid black;
	overflow-y: auto;
	background-color: #A9E2F3;
}

#btncover {
	width: 20%;
	height: 100%;
	float: left;
	border: 1px solid black;
}

#embtn {
	width: 100%;
	height: 100%;
}

#me {
	background-color: #2EFE9A;
	width: auto;
}

#other {
	background-color: #CEF6F5;
	width: auto;
}
#emobox{
	position: absolute;
	width: 100%;
	height: 100%;
	background-color: #00000015;
	z-index: 10;
	display: none;
}
#motion {
	width: 50px;
	height: 50px;
	margin: 5px;
	float: left;
}
#motion>img {
	width: 100%;
	height: 100%;
}
img{
	width: 50px;
	height: 50px;
}
#close {
	width: 20px;
	height: 20px;
	position: absolute;
	right: 0;
	top: 0;
}
</style>
</head>
<body>
	<div id=web>
		<div id=message></div>
		<div id=textbox>
			<div id=emobox>
				<div id=motion>
					<img alt="" src="/resources/img/e1.gif">
				</div>
				<div id=motion>
					<img alt="" src="/resources/img/e2.gif">
				</div>
				<div id=motion>
					<img alt="" src="/resources/img/e3.jpg">
				</div>
				<div id=motion>
					<img alt="" src="/resources/img/e4.jpg">
				</div>
				<button id=close>x</button>
			</div>
			<div id=text contenteditable="true"></div>
			<div id=btncover>
				<button id=embtn>이모티콘</button>
			</div>
		</div>
	</div>
	
</body>
</html>