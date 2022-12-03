package ;

import haxe.ui.HaxeUIApp;

class MainS {
    public static function main() {
        var app = new HaxeUIApp();
        app.ready(function() {
            app.addComponent(new MainView());

            app.start();
        });
    }
}
