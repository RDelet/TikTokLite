import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.ActivityMonitor;
using Toybox.WatchUi as Ui;


class StepsWidget {

    private var centerX;
    private var centerY;
    private var iconL = Ui.loadResource(Rez.Drawables.StepsL);
    private var iconR = Ui.loadResource(Rez.Drawables.StepsR);

    function initialize() {}

    private function getValue() as String {
        return ActivityMonitor.getInfo().steps.toString();
    }

    private function getIcon() as Graphics.BitmapReference{
        if (Time.Gregorian.info(Time.now(), Time.FORMAT_LONG).sec % 2 == 0) {
            return iconR;
        } else {
            return iconL;
        }
    }

    public function setPosition(x as Number, y as Number) {
        centerX = x;
        centerY = y;
    }

    public function draw(dc as Dc) {
        var icon = getIcon();
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