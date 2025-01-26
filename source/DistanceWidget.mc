import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.ActivityMonitor;
using Toybox.WatchUi as Ui;


class DistanceWidget {

    private var centerX;
    private var centerY;
    private var icon = Ui.loadResource(Rez.Drawables.Distance);

    function initialize() {}

    private function getValue() as String {
        return ActivityMonitor.getInfo().distance.toString();
    }

    public function setPosition(x as Number, y as Number) {
        centerX = x;
        centerY = y;
    }

    public function draw(dc as Dc) {
        var txt = getValue() as String;
        var txtDim = dc.getTextDimensions(txt, Graphics.FONT_XTINY);
        var iconWidth = icon.getWidth();
        var totalWidth = iconWidth + 5 + txtDim[0];
        var iconX = centerX - (totalWidth / 2);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawBitmap(centerX - (totalWidth / 2), centerY - (icon.getHeight() / 2), icon);
        dc.drawText(iconX + iconWidth + 5, centerY - (txtDim[1] / 2), Graphics.FONT_XTINY, txt, Graphics.TEXT_JUSTIFY_LEFT);
    }
}