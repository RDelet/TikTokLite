import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class View extends WatchUi.WatchFace {

    private var centerX;
    private var centerY;
    private var widgets = [];
    private var timeWidget;
    private var widgetTypes = [];


    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
        centerX = dc.getWidth() / 2;
        centerY = dc.getHeight() / 2;
        updateSettings();
        createWidgets();
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        updateSettings();
        drawWidgets(dc);
    }

    function onPartialUpdate(dc as Dc) {
        WatchUi.requestUpdate();
    }

    private function createWidgets(){
        widgets = [];
        for (var i=0; i < widgetAngles.size(); i++){
            var widgetType = widgetTypes[i];
            if (widgetType != 0){
                var widget = new Widget(widgetType);
                var angleRad = angleOffset - Math.toRadians(widgetAngles[i]);
                var x = centerX + widgetsRadius * Math.cos(angleRad);
                var y = centerY + widgetsRadius * Math.sin(angleRad);
                widget.setPosition(x, y);
                widgets.add(widget);
            }
        }
        timeWidget = new TimeWidget();
        timeWidget.setPosition(centerX, centerY);
    }

    private function drawWidgets(dc as Dc) as Void {
        for (var i=0; i < widgets.size(); i++) {
            var widget = widgets[i];
            widget.update();
            widget.draw(dc);
        }
        timeWidget.draw(dc);
    }

    public function getWidgets() as Array {
        widgetTypes = [];
        for (var i = 0; i < widgetAngles.size(); i++) {
            var widgetValue = getSetting("Widget_" + (i + 1).toString());
            widgetTypes.add(widgetValue);
        }
        return widgetTypes;
    }

    private function updateSettings() {
        if (updateAllSettings) {
            getWidgets();
            dateColor = getSettingColor("DateColor");
            hourColor = getSettingColor("HourColor");
            minColor = getSettingColor("MinColor");
            secColor = getSettingColor("SecColor");
            createWidgets();
            updateAllSettings = false;
        }
    }

}
