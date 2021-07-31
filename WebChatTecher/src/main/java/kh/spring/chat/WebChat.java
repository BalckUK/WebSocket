package kh.spring.chat;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/chat")
public class WebChat {

	private static Set<Session> clients = new HashSet<>();

	@OnOpen
	public void onConnect(Session client) {
		System.out.println(client.getId() + " 클라이언트가 접속했습니다.");
		clients.add(client);
	}

	@OnMessage
	public void onMessage(Session session, String message) {
		for(Session client : clients) {
			if(!client.getId().contentEquals(session.getId())) {
				Basic basic = client.getBasicRemote();
				try {
					basic.sendText(message);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
	}

}








