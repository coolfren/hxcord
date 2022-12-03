package ui;

import haxe.ui.containers.VBox;
import haxe.ui.events.MouseEvent;

@:build(haxe.ui.ComponentBuilder.build("assets/login-view.xml"))
class LoginView extends VBox {
    public function new() {
        super();
        /*button1.onClick = function(e) {
            button1.text = "Thanks!";
        }*/
    }
    
    /*@:bind(button2, MouseEvent.CLICK)
    private function onMyButton(e:MouseEvent) {
        button2.text = "Thanks!";
    }*/
}