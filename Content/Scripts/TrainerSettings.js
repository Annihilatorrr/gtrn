function readCurrentSettings()
{
    isMutedId.checked = settingsHelper.getBoolValue("isMuted", settingsWindowId.isMuted);
    showNotesLabelsId.checked = settingsHelper.getBoolValue("showNotesLabels", settingsWindowId.showNotesLabels);
    fretsNumberSliderId.value = settingsHelper.getIntValue("fretsNumber", settingsWindowId.fretsNumber);
}

function writeCurrentSettings()
{
    settingsHelper.setValue("isMuted", isMutedId.checked)
    settingsHelper.setValue("showNotesLabels", showNotesLabelsId.checked)
    settingsHelper.setValue("fretsNumber", fretsNumberId.text)
}
