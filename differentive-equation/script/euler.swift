import Foundation

let from: Double = 0.0
let to: Double = 1.0
let h: Double = 0.1
let x_0: Double = 0.0
let y_0: Double = 1.0

extension Double {
	func roundToDecimal(_ fractionDigits: Int = 9) -> Double {
		let multiplier = pow(10, Double(fractionDigits))
		return Darwin.round(self * multiplier) / multiplier
	}
	func fixedString(_ length: Int = 8, addToRight: Bool = false) -> String {
		return String(self.roundToDecimal(length - 2)).fixedString(length, addToRight: addToRight)
	}
	func absValue() -> Double {
		if self < 0 { return -self }
		return self
	}
}
extension String {
	func fixedString(_ length: Int = 8, addToRight: Bool = false) -> String {
		var string = self
		while string.count < length {
			if addToRight { string += " " }
			else { string = " " + string }
		}
		return string
	}
}

// Declare f() and phi()
func f(_ x: Double, _ y: Double) -> Double {
	return x - y
} // f()
func f_mid(_ x: Double, _ y: Double) -> Double {
	return f(x + h/2.0, y + (h/2.0)*f(x, y))
} // Keep this
func phi(_ x: Double) -> Double {
	return 0.0
} // varphi()

// Automator
let numOfStep = Int(((to - from) / h).roundToDecimal(0))

// let TAB = " & ", BRACKET = "$", BOL = "\t", EOL = " \\\\ \\hline"
let TAB = "\t", BRACKET = "", BOL = "", EOL = ""

var phix = [Double](repeating: 0.0, count: numOfStep + 1)
var x = phix, y = phix, y_1 = phix, y_2 = phix

x[0] = x_0
y[0] = y_0
y_1[0] = y_0
y_2[0] = y_0
phix[0] = phi(x[0])

print("EULER METHODS\n")
// print("\\begin{longtable}{|c|c|c|c|c|}\\hline")
print(
	BRACKET + "n" + BRACKET + TAB +
	BRACKET + "x_n" + BRACKET + TAB +
	BRACKET + "y_n" + BRACKET + TAB +
	BRACKET + "y_n" + BRACKET + " (Euler cải tiến 1)" + TAB +
	BRACKET + "y_n" + BRACKET + "(Euler cải tiến 2)" +
//	BRACKET + "\\varphi(x_n)" + BRACKET +
	EOL
)
for n in 0...numOfStep {
	if n > 0 {
		x[n] = from + Double(n)*h
		y[n] = y[n - 1] + h*f(x[n - 1], y[n - 1])
		y_1[n] = y_1[n - 1] + h*f_mid(x[n - 1], y_1[n - 1])
		y_2[n] = y_2[n - 1] + (h/2.0)*(f(x[n - 1], y_2[n - 1]) + f(x[n], y[n]))
		phix[n] = phi(x[n])
	}
	print(
		BOL +
		BRACKET + String(n) + BRACKET + TAB +
		BRACKET + String(x[n].roundToDecimal()) + BRACKET + TAB +
		BRACKET + String(y[n].roundToDecimal()) + BRACKET + TAB +
		BRACKET + String(y_1[n].roundToDecimal()) + BRACKET + TAB +
		BRACKET + String(y_2[n].roundToDecimal()) + BRACKET +
//		BRACKET + String(phix[n].roundToDecimal()) + BRACKET +
		EOL
	)
}
// print("\\end{longtable}")
