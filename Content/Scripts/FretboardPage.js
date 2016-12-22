function readCurrentSettings()
{
    isMuted = settingsHelper.getBoolValue("isMuted", isMuted);
    showNotesLabels = settingsHelper.getBoolValue("showNotesLabels", showNotesLabels);
    fretsNumber = settingsHelper.getIntValue("fretsNumber", fretsNumber);
    console.debug("readCurrentSettings: isMuted = ", isMuted)
    console.debug("readCurrentSettings: showNotesLabels = ", showNotesLabels)
    console.debug("readCurrentSettings: fretsNumber = ", fretsNumber)
}

function updateSettings()
{
    FretboardPageJs.readCurrentSettings();
    noteTrainer.onContinueWithNewSettings(fretBoard.stringNumber, fretBoard.fretsNumber);
}
