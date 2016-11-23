function onSettingsWindowClosed()
{
    isMuted = settingsWindow.fretSettings.isMuted;
    showNotesLabels = settingsWindow.fretSettings.showNotesLabels;
    console.debug("onSettingsWindowClosed: isMuted = ", isMuted)
    console.debug("onSettingsWindowClosed: showNotesLabels = ", showNotesLabels)
}
