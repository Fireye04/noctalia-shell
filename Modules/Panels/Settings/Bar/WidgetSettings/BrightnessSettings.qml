import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

ColumnLayout {
  id: root
  spacing: Style.marginM

  // Properties to receive data from parent
  property var widgetData: null
  property var widgetMetadata: null

  signal settingsChanged(var settings)

  // Local state
  property string valueDisplayMode: widgetData.displayMode !== undefined ? widgetData.displayMode : widgetMetadata.displayMode
  property bool valueReverseScroll: widgetData.reverseScroll !== undefined ? widgetData.reverseScroll : widgetMetadata.reverseScroll

  function saveSettings() {
    var settings = Object.assign({}, widgetData || {});
    settings.displayMode = valueDisplayMode;
    settings.reverseScroll = valueReverseScroll;
    return settings;
  }

  NComboBox {
    label: I18n.tr("bar.volume.display-mode-label")
    description: I18n.tr("bar.volume.display-mode-description")
    minimumWidth: 200
    model: [
      {
        "key": "onhover",
        "name": I18n.tr("display-modes.on-hover")
      },
      {
        "key": "alwaysShow",
        "name": I18n.tr("display-modes.always-show")
      },
      {
        "key": "alwaysHide",
        "name": I18n.tr("display-modes.always-hide")
      }
    ]
    currentKey: valueDisplayMode
    onSelected: key => {
                  valueDisplayMode = key;
                  settingsChanged(saveSettings());
                }
  }

  NToggle {
    label: I18n.tr("bar.volume.reverse-scrolling-label")
    description: I18n.tr("bar.volume.reverse-scrolling-description")
    checked: valueReverseScroll
    onToggled: checked => {
                 valueReverseScroll = checked;
                 settingsChanged(saveSettings());
               }
    visible: valueEnableScrollWheel
  }
}
