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

function getRandomNotesArrayWithOneDefined(definedNoteName, arraySize)
{
    var noteNames = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];
    var randomNotes = [];

    while(randomNotes.length < arraySize)
    {
        var randomnumber = Math.floor(Math.random() * noteNames.length); // [0...11]
        if(randomNotes.indexOf(noteNames[randomnumber]) > -1)
        {
            continue;
        }

        randomNotes[randomNotes.length] = noteNames[randomnumber];
    }

    if (randomNotes.indexOf(definedNoteName) == -1)
    {
        randomNotes[Math.floor(Math.random() * arraySize)] = definedNoteName; // [0...arraySize - 1]
    }

    return randomNotes;
}
