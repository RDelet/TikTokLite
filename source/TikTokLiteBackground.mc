import Toybox.Application;
import Toybox.Graphics;
import Toybox.WatchUi;


class Background extends WatchUi.Drawable {

    function initialize() {
        var dictionary = {:identifier => "Background"};
        Drawable.initialize(dictionary);
    }

    function draw(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_TRANSPARENT, Application.Properties.getValue("BackgroundColor"));
        dc.clear();
    }

}
