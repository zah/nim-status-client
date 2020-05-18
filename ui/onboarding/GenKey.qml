import QtQuick 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11
import QtQuick.Dialogs 1.3
import im.status.desktop.Status 1.0

SwipeView {
  id: swipeView
  anchors.fill: parent
  currentIndex: 0

  property var generatedAccounts: onboardingLogic.generatedAddresses

  onCurrentIndexChanged: {
    console.log("onCurrentIndexChanged: " + currentIndex);
  }

  ListModel {
    id: generatedAccountsModel
  }

  Item {
    id: wizardStep2
    property int selectedIndex: 0

    Text {
      text: "Generated accounts"
      font.pointSize: 36
      anchors.top: parent.top
      anchors.topMargin: 20
      anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
      anchors.top: parent.top
      anchors.topMargin: 50
      //anchors.horizontalCenter: parent.horizontalCenter

      Column {
        spacing: 10
        ButtonGroup {
          id: accountGroup
        }

        Repeater {
          model: generatedAccountsModel
          Rectangle {
            height: 32
            width: 32
            //border.width: 1
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            Row {
              RadioButton {
                checked: index == 0 ? true : false
                ButtonGroup.group: accountGroup
                onClicked: {
                  wizardStep2.selectedIndex = index;
                }
              }
              Column {
                Image {
                  source: identicon
                }
              }
              Column {
                Text {
                  text: alias
                }
                Text {
                  text: publicKey
                  width: 160
                  elide: Text.ElideMiddle
                }

              }
            }
          }
        }
      }


    }

    Button {
      text: "Select"
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.bottom: parent.bottom
      anchors.bottomMargin: 20
      onClicked: {
        console.log("button: " + wizardStep2.selectedIndex);

        swipeView.incrementCurrentIndex();
      }
    }
  }

  Item {
    id: wizardStep3

    Rectangle {
      color: "#EEEEEE"
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.centerIn: parent
      height: 32
      width: parent.width - 40
      TextInput {
        id: passwordInput
        anchors.fill: parent
        focus: true
        echoMode: TextInput.Password
      }
    }

    Button {
      text: "Next"
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.bottom: parent.bottom
      anchors.bottomMargin: 20
      onClicked: {
        console.log("password: " + passwordInput.text);

        swipeView.incrementCurrentIndex();
      }
    }
  }

  Item {
    id: wizardStep4

    Rectangle {
      color: "#EEEEEE"
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.centerIn: parent
      height: 32
      width: parent.width - 40

      TextInput {
        id: confirmPasswordInput
        anchors.fill: parent
        focus: true
        echoMode: TextInput.Password
      }
    }

    MessageDialog {
      id: passwordsDontMatchError
      title: "Error"
      text: "Passwords don't match"
      icon: StandardIcon.Warning
      standardButtons: StandardButton.Ok
      onAccepted: {
        confirmPasswordInput.clear();
      }
    }

    Button {
      text: "Finish"
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.bottom: parent.bottom
      anchors.bottomMargin: 20
      onClicked: {
        console.log("confirm clicked " + confirmPasswordInput.text + " : " + passwordInput.text);

        if (confirmPasswordInput.text != passwordInput.text) {
          passwordsDontMatchError.open();
        }
        else {
          swipeView.incrementCurrentIndex();
          let selectedAccount = swipeView.generatedAccounts[wizardStep2.selectedIndex];
          const multiAccount = {
            "accountID": selectedAccount.id,
            "paths": Object.keys(selectedAccount.derived),
            "password": passwordInput.text
        }
          console.log("selectedAccount: " + JSON.stringify(selectedAccount));
          console.log("multiAccount: " + JSON.stringify(multiAccount));
          const storeResponse = onboardingLogic.storeAccountAndLogin(JSON.stringify(selectedAccount), passwordInput.text)
        //   let storeResponse = Status.multiAccountStoreDerivedAccounts(JSON.stringify(multiAccount));
          console.log("storeResponse: " + storeResponse);
          selectedAccount.derived = JSON.parse(storeResponse);
        }
      }
    }
  }
  onGeneratedAccountsChanged: {
    console.log("=====> generatedAccounts: ", generatedAccounts)
    if (generatedAccounts === null || generatedAccounts === "") {
      return;
    }
    generatedAccountsModel.clear();
    swipeView.generatedAccounts = JSON.parse(generatedAccounts);
    for (let i = 0; i < swipeView.generatedAccounts.length; ++i) {
      let acc = swipeView.generatedAccounts[i];
      let alias = onboardingLogic.generateAlias(acc.publicKey);
      let identicon = onboardingLogic.identicon(acc.publicKey);
      generatedAccountsModel.append({"publicKey": acc.publicKey, alias, identicon});
    }
  }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

