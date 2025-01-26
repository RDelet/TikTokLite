import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
using Toybox.WatchUi as Ui;

class BatteryWidget {

    var centerX;
    var centerY;
    var batteryValue;

    var battery100 = Ui.loadResource(Rez.Drawables.Battery100);
    var battery75 = Ui.loadResource(Rez.Drawables.Battery75);
    var battery50 = Ui.loadResource(Rez.Drawables.Battery50);
    var battery25 = Ui.loadResource(Rez.Drawables.Battery25);

    function initialize() {}

    private function updateValue() as Void {
        batteryValue = System.getSystemStats().battery;
    }

    private function getTextFormat() as String {
        if (batteryValue == 100) {
            return "%03d";
        } else {
            return "%02d";
        }
    }

    private function getIcon() as Graphics.BitmapReference {
        if (batteryValue > 75) {
            return battery100;
        } else if (batteryValue > 50) {
            return battery75;
        } else if (batteryValue > 25) {
            return battery50;
        } else {
            return battery25;
        }
    }

    public function setPosition(x as Number, y as Number) {
        centerX = x;
        centerY = y;
    }

    public function draw(dc as Dc) {
        updateValue();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        var icon = getIcon();
        var txt = Lang.format("$1$%", [batteryValue.format(getTextFormat())]);
        var txtDim = dc.getTextDimensions(txt, Graphics.FONT_XTINY);
        var totalWidth = icon.getWidth() + 5 + txtDim[0];
        var iconX = centerX - (totalWidth / 2);

        dc.drawBitmap(centerX - (totalWidth / 2), centerY - (icon.getHeight() / 2), icon);
        dc.drawText(iconX + icon.getWidth() + 5, centerY - (txtDim[1] / 2), Graphics.FONT_XTINY, txt, Graphics.TEXT_JUSTIFY_LEFT);
    }
}