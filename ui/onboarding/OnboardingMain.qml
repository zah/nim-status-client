import QtQuick 2.3
import QtQml.StateMachine 1.14 as DSM
import QtQuick.Controls 2.3

Page {
    id: onboardingMain
    property string state
    anchors.fill: parent

    DSM.StateMachine {
        id: stateMachine
        initialState: stateIntro
        running: onboardingMain.visible

        DSM.State {
            id: stateIntro
            onEntered: function() { console.log("======> ENTER intro state"); intro.visible = true; }
            onExited: intro.visible = false

            DSM.SignalTransition {
                targetState: keysMainState
                signal: intro.btnGetStarted.clicked
            }
        }

        DSM.State {
            id: keysMainState
            onEntered: function() { console.log("======> ENTER keys main state"); keysMain.visible = true; }
            onExited: keysMain.visible = false

            DSM.SignalTransition {
                targetState: existingKeyState
                signal: keysMain.btnExistingKey.clicked
            }

            DSM.SignalTransition {
                targetState: genKeyState
                signal: keysMain.btnGenKey.clicked
            }
        }

        DSM.State {
            id: existingKeyState
            onEntered: function() { console.log("======> ENTER seed state"); existingKey.visible = true; }
            onExited: existingKey.visible = false

//            DSM.SignalTransition {
//                targetState: keysMainState
//                signal: keysMain.btnExistingKey.clicked
//            }
        }

        DSM.State {
            id: genKeyState
            onEntered: function() { console.log("======> ENTER gen key state"); genKey.visible = true; }
            onExited: genKey.visible = false

//            DSM.SignalTransition {
//                targetState: keysMainState
//                signal: keysMain.btnExistingKey.clicked
//            }
        }

        DSM.FinalState {
            id: appState
            onEntered: function() { console.log("======> ENTER app state"); app.visible = true; }
            onExited: app.visible = false
        }
    }

    Intro {
        id: intro
        anchors.fill: parent
        visible: true
    }

    KeysMain {
        id: keysMain
        anchors.fill: parent
        visible: false
    }

    ExistingKey {
        id: existingKey
        anchors.fill: parent
        visible: false
    }

    GenKey {
        id: genKey
        anchors.fill: parent
        visible: false
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:770;width:1232}
}
##^##*/
