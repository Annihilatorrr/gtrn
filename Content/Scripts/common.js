.import QtQml 2.2 as QtQml

function createObjectFromQmlFile(fileName, parentComponent, settings)
{
    var objectToCreate;
    var component = Qt.createComponent(fileName);
    if (component.status === QtQml.Component.Ready)
    {
        objectToCreate = finishCreation(component, parentComponent, settings)
    }
    else
    {
        component.statusChanged.connect(function(status)
        {
            if (status === QtQml.Component.Ready)
            {
                objectToCreate = finishCreation(component, parentComponent, settings);
            }
            else if (status === QtQml.Component.Error)
            {
                console.log("Error while creating component from:", filename, ":", component.errorString());
            }
        });
    }
    return objectToCreate;
}

function finishCreation(component, parentComponent, settings)
{
    var objectToCreate = component.createObject(parentComponent, settings);
    if (objectToCreate === null)
    {
        console.log("Error creating object");
    }
    return objectToCreate;
}

function getRandomNotesArrayWithOneDefined(definedNoteName, arraySize)
{
    var noteNames = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];
    var randomNotes = [];
    var noteNamesLength = noteNames.length;

    while(randomNotes.length < arraySize)
    {
        var randomnumber = Math.floor(Math.random() * noteNamesLength); // [0...11]
        if(randomNotes.indexOf(noteNames[randomnumber]) == -1)
        {
            randomNotes[randomNotes.length] = noteNames[randomnumber];
        }
    }

    if (randomNotes.indexOf(definedNoteName) == -1)
    {
        randomNotes[Math.floor(Math.random() * arraySize)] = definedNoteName; // [0...arraySize - 1]
    }

    return randomNotes;
}
