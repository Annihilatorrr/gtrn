function createObjectFromQmlFile(fileName, settings, parentComponent)
{
    var objectToCreate;
    var component = Qt.createComponent(fileName);
    if (component.status === Component.Ready)
    {
        objectToCreate = component.createObject(parentComponent, settings);
    }
    else
    {
        console.debug("Error while creating component from:", filename, ": ", component.errorString())
    }
    return objectToCreate;
}
