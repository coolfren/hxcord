package networking;

import sys.net.Host;
import sys.net.Socket;
import haxe.net.WebSocketServer;

//this class lets you do captchas, mainly for logging in.
//TODO: maybe make this a special web widget?
class Captcha {
    public static function generate():String {
        var key = "";
        final sitekey = "f5561ba9-8f1e-40ca-9b5b-a0b3f719ef34";
        final content = '<script src="https://js.hcaptcha.com/1/api.js" async defer></script>the captcha:<br><div class="h-captcha" data-sitekey="${sitekey}" data-theme="dark"></div><script defer>setTimeout(function() {var frame = document.getElementsByTagName("iframe").item(0); function a() {if (frame.getAttribute("data-hcaptcha-response") == "") {setTimeout(function() {a()}, 1000);} else {console.log("gottem"); var socket = new WebSocket("ws://127.0.0.1:8080"); socket.addEventListener("open", (event) => {socket.send(frame.getAttribute("data-hcaptcha-response"));});}} setTimeout(function () {a();}, 1000);}, 2500);</script>';
        final header = "HTTP/1.1 200 OK\r\n" +
        'Content-Type: text/html\r\n' +
        'Content-Length: ${content.length}\r\n' +
        "Date: Wed, 02 Nov 2022 21:40:15 GMT\r\n" +
        "Connection: closed\r\n" +
        "Last-Modified: Tue, 04 Oct 2022 16:02:39 GMT\r\n\r\n" +
        content;
        var httpserver = new Socket();
        httpserver.bind(new Host("127.0.0.1"), 3000);
        httpserver.listen(1);
        final client = httpserver.accept();
        client.write(header);
        var recieved:Bool = false;
        var ws = WebSocketServer.create("127.0.0.1", 8080, 1, true);
        var ws2 = null;
        while (ws2 == null) {
            ws2 = ws.accept();
        }
        ws2.onmessageString = function(message) {
            key = message;
            recieved = true;
        };
        while (!recieved) {
            ws2.process();
            Sys.sleep(0.1);
        }
        ws2.close();
        httpserver.close();
        return key;
    }
}