import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Page {
    RowLayout {
        anchors.centerIn: parent

        Button {
            text: qsTr("Popup")
            highlighted: true
        }

        Button {
            text: qsTr("Page")
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/