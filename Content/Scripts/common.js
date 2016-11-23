function createComponentFromQmlFile(fileName, settings, parentComponent)
{
    var settingsWindow;
    var component = Qt.createComponent(fileName);
    if (component.status === Component.Ready)
    {
        settingsWindow = component.createObject(parentComponent, settings);
    }
    else
    {
        console.log("Error while creating component from:", filename, ": ", component.errorString())
    }
    return settingsWindow;
}
