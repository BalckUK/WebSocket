<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
	function updateScroll() {
		var element = document.getElementById("message-area");
		element.scrollTop = element.scrollHeight;
	}

	$(function() {

		var ws = new WebSocket("ws://localhost:8035/chat");
		ws.onmessage = function(e){
			var line = $("<div>");
			line.append(e.data);
			$(".message-area").append(line);
		}
		$(".input-area").on("keydown", function(e) {
			if (e.keyCode == 13) {
				var text = $(".input-area").html();
				var line = $("<div>");
				line.append(text);
				$(".message-area").append(line);
				$(".input-area").html("");
				ws.send(text);
				updateScroll();
				return false;
			}
		})
	})
</script>
<style>
* {
	box-sizing: border-box;
}

.chat-box {
	border: 1px solid black;
	width: 400px;
	height: 400px;
	margin: auto;
}

.message-area {
	border-bottom: 1px solid black;
	width: 100%;
	height: 90%;
	overflow-y: auto;
	word-wrap: break-word;
}

.input-area {
	width: 100%;
	height: 10%;
	overflow-y: auto;
}
</style>
</head>
<body>
	<div class="chat-box">
		<div class="message-area" id="message-area"></div>
		<div class="input-area" contenteditable="true"></div>
	</div>
</body>
</html>