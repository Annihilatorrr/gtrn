function createComponentFromQmlFile(fileName)
{
    var settingsWindow;
    var component = Qt.createComponent(fileName);
    if (component.status === Component.Ready)
    {
        settingsWindow = component.createObject(root);
    }
    else
    {
        console.log("Error while creating component from:", filename, ": ", component.errorString())
    }
    return settingsWindow;
}
