function readCurrentSettings()
{
    isMuted = settingsWindow.fretSettings.isMuted;
    showNotesLabels = settingsWindow.fretSettings.showNotesLabels;
    fretsNumber = settingsWindow.fretSettings.fretsNumber;
    console.debug("readCurrentSettings: isMuted = ", isMuted)
    console.debug("readCurrentSettings: showNotesLabels = ", showNotesLabels)
    console.debug("readCurrentSettings: fretsNumber = ", fretsNumber)
}
