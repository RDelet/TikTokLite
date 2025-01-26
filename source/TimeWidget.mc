import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
using Toybox.WatchUi as Ui;

class TimeWidget {

    private var centerX;
    private var centerY;
    private var textColor = {0 => Graphics.COLOR_WHITE,
                             1 => Graphics.COLOR_RED,
                             2 => Graphics.COLOR_DK_RED,
                             3 => Graphics.COLOR_ORANGE,
                             4 => Graphics.COLOR_YELLOW,
                             5 => Graphics.COLOR_BLUE,
                             6 => Graphics.COLOR_DK_BLUE,
                             7 => Graphics.COLOR_GREEN,
                             8 => Graphics.COLOR_DK_GREEN,
                             9 => Graphics.COLOR_PURPLE,
                             10 => Graphics.COLOR_PINK};

    function initialize() {
    }

    function getTextColor(settingName as String) {
        var colorValue = textColor.get(Application.Properties.getValue(settingName));
        if (colorValue == null){
            colorValue = Graphics.COLOR_LT_GRAY;
        }
        return colorValue;
    }

    public function setPosition(x as Number, y as Number) {
        centerX = x;
        centerY = y;
    }

    public function draw(dc as Dc) {
        var today = Time.Gregorian.info(Time.now(), Time.FORMAT_LONG);

        // Text
        var hourTxt = today.hour.format("%02d");
        var colonTxt = ":";
        var minTxt = today.min.format("%02d");
        var secTxt = today.sec.format("%02d");
        // Policy
        var largeNumberFont = Graphics.FONT_NUMBER_HOT;
        var tinyNumberFont = Graphics.FONT_NUMBER_MILD;
        var tinyTextFont = Graphics.FONT_TINY;
        // Size
        var hourWidth = dc.getTextDimensions(hourTxt, largeNumberFont)[0];
        var colonWidth = dc.getTextDimensions(colonTxt, largeNumberFont)[0] + 3;
        var minWidth = dc.getTextDimensions(minTxt, largeNumberFont)[0];
        var secWidth = dc.getTextDimensions(secTxt, tinyNumberFont)[0];
        var largeHeight = dc.getTextDimensions(hourTxt, largeNumberFont)[1];
        var tinyHeight = dc.getTextDimensions(secTxt, tinyNumberFont)[1];
        var totalWidth = hourWidth + colonWidth + minWidth + secWidth;
        // Compute start position
        var hourY = centerY - largeHeight * 0.5;
        var startX = centerX - (totalWidth / 2);
        // Hour
        dc.setColor(getTextColor("HourColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(startX, hourY, largeNumberFont, hourTxt, Graphics.TEXT_JUSTIFY_LEFT);
        // Separator
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        startX += hourWidth;
        dc.drawText(startX, hourY, largeNumberFont, colonTxt, Graphics.TEXT_JUSTIFY_LEFT);
        // Minutes
        startX += colonWidth;
        dc.setColor(getTextColor("MinColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(startX, hourY, largeNumberFont, minTxt, Graphics.TEXT_JUSTIFY_LEFT);
        // Secondes
        dc.setColor(getTextColor("SecColor"), Graphics.COLOR_TRANSPARENT);
        startX += minWidth;
        var secOffsetY = hourY + (largeHeight - tinyHeight) * 0.7;
        dc.drawText(startX, secOffsetY, tinyNumberFont, secTxt, Graphics.TEXT_JUSTIFY_LEFT);
        // Draw date
        dc.setColor(getTextColor("DateColor"), Graphics.COLOR_TRANSPARENT);
        var dateTxt = Lang.format("$1$ $2$ $3$", [today.day_of_week, today.day, today.month]);
        var dateHeight = dc.getTextDimensions(dateTxt, tinyTextFont)[1];
        dc.drawText(centerX, hourY - dateHeight * 0.5, tinyTextFont, dateTxt, Graphics.TEXT_JUSTIFY_CENTER);
    }
}