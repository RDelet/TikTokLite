import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class TikTokLiteView extends WatchUi.WatchFace {

    var centerX;
    var centerY;

    var batteryWidget = new BatteryWidget();
    var timeWidget = new TimeWidget();

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
        centerX = dc.getWidth() / 2;
        centerY = dc.getHeight() / 2;
        timeWidget.setPosition(centerX, centerY);
        batteryWidget.setPosition(centerX, centerY + centerY * 0.6);
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        timeWidget.draw(dc);
        batteryWidget.draw(dc);
    }

    function onPartialUpdate(dc as Dc) {
        WatchUi.requestUpdate();
    }

}
