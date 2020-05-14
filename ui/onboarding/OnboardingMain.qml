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
            onEntered: intro.visible = true
            onExited: intro.visible = false

            DSM.SignalTransition {
                targetState: keysMainState
                signal: intro.btnGetStarted.clicked
            }
        }

        DSM.State {
            id: keysMainState
            onEntered: keysMain.visible = true
            onExited: keysMain.visible = false

            DSM.SignalTransition {
                targetState: enterSeedState
                signal: keysMain.btnExistingKey.clicked
            }

            DSM.SignalTransition {
                targetState: newKeyState
                signal: keysMain.btnGenKey.clicked
            }
        }

        DSM.State {
            id: enterSeedState
            onEntered: enterSeed.visible = true
            onExited: enterSeed.visible = false

//            DSM.SignalTransition {
//                targetState: keysMainState
//                signal: keysMain.btnExistingKey.clicked
//            }
        }

        DSM.State {
            id: genKeyState
            onEntered: genKey.visible = true
            onExited: genKey.visible = false

//            DSM.SignalTransition {
//                targetState: keysMainState
//                signal: keysMain.btnExistingKey.clicked
//            }
        }

        DSM.FinalState {
            id: appState
            onEntered: app.visible = true
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

    EnterSeed {
        id: enterSeed
        anchors.fill: parent
        visible: false
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:770;width:1232}
}
##^##*/
