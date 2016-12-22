function readCurrentSettings()
{
    isMuted = settingsHelper.getBoolValue("isMuted", isMuted);
    showNotesLabels = settingsHelper.getBoolValue("showNotesLabels", showNotesLabels);
    activeFretsNumber = settingsHelper.getIntValue("activeFretsNumber", activeFretsNumber);
    console.debug("readCurrentSettings: isMuted = ", isMuted)
    console.debug("readCurrentSettings: showNotesLabels = ", showNotesLabels)
    console.debug("readCurrentSettings: activeFretsNumber = ", activeFretsNumber)
}

function updateSettings()
{
    FretboardPageJs.readCurrentSettings();
    noteTrainer.onContinueWithNewSettings(fretBoard.stringNumber, fretBoard.activeFretsNumber);
}
