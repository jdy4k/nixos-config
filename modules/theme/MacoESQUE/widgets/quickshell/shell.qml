import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

PanelWindow {
  id: panelWindow
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 32
  color: '#60000000'
  
  Row {
    id: workspacesRow
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: 25
    spacing: 35

    Repeater {
      model: Hyprland.workspaces
      
      Rectangle {
        visible: modelData.id !== -99
        width: workspaceText.width
        height: workspaceText.height
        color: "transparent"

        Text {
          id: workspaceText
          anchors.centerIn: parent
          text: modelData.id
          font.family: "FiraCode Nerd Font"
          font.pixelSize: 14
          color: "white"
          opacity: modelData.active ? 1.0 : 0.5
        }

        Rectangle {
          visible: modelData.active
          anchors.bottom: parent.bottom
          anchors.horizontalCenter: parent.horizontalCenter
          width: workspaceText.width + 20
          anchors.bottomMargin: -8
          height: 2
          color: "white"
        }

        MouseArea {
          anchors.fill: parent
          onClicked: Hyprland.dispatch(`workspace ${modelData.id}`)
        }
      }
    }
  }
  
  Row {
    id: indicatorsRow
    anchors.right: clock.left
    anchors.verticalCenter: parent.verticalCenter
		anchors.rightMargin: 20
    spacing: 15
    height: 32

    // Volume Indicator
    Rectangle {
      width: Math.max(25, volumeText.width)
      height: 32
      color: "transparent"

      Text {
        id: volumeText
        anchors.top: parent.top
        anchors.topMargin: 3.5
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "FiraCode Nerd Font"
        font.pixelSize: 20
        color: "white"
        text: "󰕾"

        Process {
          id: volumeProc
          command: ["sh", "-c", "VOL=$(amixer get Master 2>/dev/null | grep -oP '\\[\\K\\d+(?=%\\])' | head -1 || echo '0'); MUTE=$(amixer get Master 2>/dev/null | grep -oP '\\[\\K(off|on)(?=\\])' | head -1 || echo 'on'); echo \"$VOL|$MUTE\""]
          running: true

          stdout: StdioCollector {
            onStreamFinished: {
              var parts = this.text.trim().split("|")
              if (parts.length === 2) {
                var vol = parseInt(parts[0]) || 0
                var muted = parts[1] === "off"
                
                if (muted) {
                  volumeText.text = "󰝟"
                  volumeText.color = "#ff6b6b"
                } else if (vol === 0) {
                  volumeText.text = "󰕿"
                  volumeText.color = "white"
                } else if (vol < 50) {
                  volumeText.text = "󰖀"
                  volumeText.color = "white"
                } else if (vol >= 50) {
                  volumeText.text = "󰕾"
                  volumeText.color = "white"
                } else {
                  volumeText.text = "󰕿"
                  volumeText.color = "white"
                }
              }
              // Re-run after a short delay to check for changes
              volumeTimer.restart()
            }
          }
        }

        Timer {
          id: volumeTimer
          interval: 500
          running: false
          onTriggered: volumeProc.running = true
        }
      }
    }

    // Battery Indicator
    Rectangle {
      width: Math.max(25, batteryText.width)
      height: 32
      color: "transparent"

      Text {
        id: batteryText
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "FiraCode Nerd Font"
        font.pixelSize: 16
        color: "white"
        text: "󰁹"

        Process {
          id: batteryProc
          command: ["sh", "-c", "if command -v inotifywait >/dev/null 2>&1; then inotifywait -e modify /sys/class/power_supply/BAT0/capacity /sys/class/power_supply/BAT0/status 2>/dev/null; fi; CAP=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo '0'); STATUS=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo 'Unknown'); echo \"$CAP|$STATUS\""]
          running: true

          stdout: StdioCollector {
            onStreamFinished: {
              var parts = this.text.trim().split("|")
              if (parts.length === 2) {
                var cap = parseInt(parts[0]) || 0
                var charging = parts[1] === "Charging" || parts[1] === "Full"
                
                if (cap >= 90) {
                  batteryText.text = charging ? "󰂅" : "󰁹"
                } else if (cap >= 70) {
                  batteryText.text = charging ? "󰂋" : "󰂀"
                } else if (cap >= 50) {
                  batteryText.text = charging ? "󰂆" : "󰁾"
                } else if (cap >= 30) {
                  batteryText.text = charging ? "󰂇" : "󰁻"
                } else if (cap >= 15) {
                  batteryText.text = charging ? "󰂈" : "󰁺"
                } else {
                  batteryText.text = charging ? "󰂉" : "󰁹"
                }
                
                if (cap < 15 && !charging) {
                  batteryText.color = "#ff6b6b"
                } else {
                  batteryText.color = "white"
                }
              }
              // Re-run to wait for next change
              batteryProc.running = true
            }
          }
        }
      }
    }

    // WiFi Indicator
    Rectangle {
      width: Math.max(25, wifiText.width)
      height: 32
      color: "transparent"

      Text {
        id: wifiText
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "FiraCode Nerd Font"
        font.pixelSize: 16
        color: "white"
        text: "󰤨"

        Process {
          id: wifiProc
          command: ["sh", "-c", "ACTIVE=$(nmcli -t -f active,ssid,signal dev wifi | grep '^yes:'); if [ -z \"$ACTIVE\" ]; then echo 'Disconnected'; else SIGNAL=$(echo \"$ACTIVE\" | cut -d: -f3); echo \"$SIGNAL\"; fi"]
          running: true

          stdout: StdioCollector {
            onStreamFinished: {
              var signalStr = this.text.trim()
              if (signalStr === "Disconnected" || signalStr === "") {
                wifiText.text = "󰤭"
                wifiText.color = "#ff6b6b"
              } else {
                var signal = parseInt(signalStr) || 0
                if (signal >= 75) {
                  wifiText.text = "󰤨"
                  wifiText.color = "white"
                } else if (signal >= 50) {
                  wifiText.text = "󰤥"
                  wifiText.color = "white"
                } else if (signal >= 25) {
                  wifiText.text = "󰤤"
                  wifiText.color = "white"
                } else {
                  wifiText.text = "󰤣"
                  wifiText.color = "#ff6b6b"
                }
              }
              // Re-run after a delay to check for changes
              wifiTimer.restart()
            }
          }
        }

        Timer {
          id: wifiTimer
          interval: 2000
          running: false
          onTriggered: wifiProc.running = true
        }
      }
    }
  }

  Text {
    id: clock
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: 12

    font.family: "SFProText Nerd Font Medium"
    font.pixelSize: 15
    color: "white"

    Process {
      // give the process object an id so we can talk
      // about it from the timer
      id: dateProc

      command: ["date", "+%b %d %a  %I:%M %p"]
      running: true

      stdout: StdioCollector {
        onStreamFinished: clock.text = this.text
      }
    }

    // use a timer to rerun the process at an interval
    Timer {
      // 1000 milliseconds is 1 second
      interval: 1000

      // start the timer immediately
      running: true

      // run the timer again when it ends
      repeat: true

      // when the timer is triggered, set the running property of the
      // process to true, which reruns it if stopped.
      onTriggered: dateProc.running = true
    }
  }

}
