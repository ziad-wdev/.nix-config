import QtQuick

QtObject {
	<* for name, value in colors *>
		readonly property color {{name}}: "{{value.default.hex}}"
	<* endfor *>

	readonly property color base00: Qt.hsva(primary.hsvHue, 0.05, 0.05, primary.a)
	readonly property color base01: Qt.hsva(primary.hsvHue, 0.05, 0.15, primary.a)
	readonly property color base02: Qt.hsva(primary.hsvHue, 0.05, 0.25, primary.a)
	readonly property color base03: Qt.hsva(primary.hsvHue, 0.05, 0.40, primary.a)
	readonly property color base04: Qt.hsva(primary.hsvHue, 0.05, 0.60, primary.a)
	readonly property color base05: Qt.hsva(primary.hsvHue, 0.05, 0.75, primary.a)
	readonly property color base06: Qt.hsva(primary.hsvHue, 0.05, 0.90, primary.a)
	readonly property color base07: Qt.hsva(primary.hsvHue, 0.05, 0.98, primary.a)

	readonly property color alphaBackground: Qt.alpha(base00, 0.2)
	readonly property color alphaForeground: Qt.alpha(base07, 0.5)
}
