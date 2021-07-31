package kh.WebChet.chat;

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
public class Webchat {

	private static Set<Session> clients = new HashSet<>();

	@OnOpen
	public void onConnect(Session client) {
		for(Session tmp : clients ) {
			if(tmp != client) {
				Basic basic = tmp.getBasicRemote();
				try {
					basic.sendText(client.getId()+"님이 입장하셨습니다.");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		clients.add(client);
	}

	@OnMessage
	public void onMessage(Session session, String message) {
		String mess = session.getId() + " : " + message;
		for(Session tmp : clients ) {
			if(tmp != session) {
				Basic basic = tmp.getBasicRemote();
				try {
					
					basic.sendText(mess);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

	@OnClose
	public void outConnect(Session client) {
		clients.remove(client);
		for(Session tmp : clients ) {
			if(tmp != client) {
				Basic basic = tmp.getBasicRemote();
				try {
					basic.sendText(client.getId()+"님이 퇴장하셨습니다.");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
	}
}
