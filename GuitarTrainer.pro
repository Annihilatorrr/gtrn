QT += qml quick multimedia core gui

CONFIG += c++11

SOURCES += main.cpp \
    soundplayer.cpp \
    settingshelper.cpp \
    notetrainer.cpp \
    notenameconverter.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML2_IMPORT_PATH += ./SettingsProvider

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    soundplayer.h \
    settingshelper.h \
    notetrainer.h \
    notenameconverter.h
