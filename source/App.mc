import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class App extends Application.AppBase {

    function initialize() { AppBase.initialize(); }
    function onStart(state as Dictionary?) as Void {}
    function onStop(state as Dictionary?) as Void {}
    function getInitialView() as [Views] or [Views, InputDelegates] { return [ new View() ]; }
    function onSettingsChanged() as Void {
        updateAllSettings = true;
        WatchUi.requestUpdate();
    }

}

function getApp() as App {
    return Application.getApp() as App;
}