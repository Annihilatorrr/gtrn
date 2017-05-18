QT += qml quick multimedia core gui

CONFIG += c++11 declarative_debug qml_debug

SOURCES += main.cpp \
    soundplayer.cpp \
    settingshelper.cpp \
    notetrainer.cpp

RESOURCES += qml.qrc

QT_LOGGING_RULES=qml=false
# Additional import path used to resolve QML modules in Qt Creator's code model
QML2_IMPORT_PATH += ./SettingsProvider

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    soundplayer.h \
    settingshelper.h \
    notetrainer.h

RC_ICONS = ./Content/Icons/appicon.ico
