package ;

import haxe.ui.events.MouseEvent;
import hx.widgets.Window;
import haxe.ui.containers.VBox;

@:build(haxe.ui.ComponentBuilder.build("assets/main-view.xml"))
class MainView extends VBox {
    
    public function new() {
        super();
       
    }   
    @:bind(s, MouseEvent.CLICK)
    function onPress(e:MouseEvent)
    {
        trace("hrr");
    }
}