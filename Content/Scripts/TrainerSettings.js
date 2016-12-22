function readCurrentSettings()
{
    isMutedId.checked = settingsHelper.getBoolValue("isMuted", settingsWindowId.isMuted);
    showNotesLabelsId.checked = settingsHelper.getBoolValue("showNotesLabels", settingsWindowId.showNotesLabels);
    activeFretsNumberSliderId.value = settingsHelper.getIntValue("activeFretsNumber", settingsWindowId.activeFretsNumber);
}

function writeCurrentSettings()
{
    settingsHelper.setValue("isMuted", isMutedId.checked)
    settingsHelper.setValue("showNotesLabels", showNotesLabelsId.checked)
    settingsHelper.setValue("activeFretsNumber", activeFretsNumberId.text)
}
