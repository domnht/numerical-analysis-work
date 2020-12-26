import Foundation

let from: Double = 0.0
let to: Double = 1.5
let x_0: Double = 0
let y_0: Double = 1
let h: Double = 0.25

// Extension for number processing
extension Double {
	func roundToDecimal(_ fractionDigits: Int = 9) -> Double {
		let multiplier = pow(10, Double(fractionDigits))
		return Darwin.round(self*multiplier)/multiplier
	}
}

// Declare f() and phi()
func f(_ x: Double, _ y: Double) -> Double {
	return 2*x*y + exp(pow(x, 2))
} // f_n(x, y) = 2xy + e^(x^2)
func f_mid(_ x: Double, _ y: Double) -> Double {
	return f(x + h/2.0, y + (h/2.0)*f(x, y))
} // f_{n + 1/2}(x, y), Don't touch this!
func phi(_ x: Double) -> Double {
	return (x + 1)*exp(pow(x, 2))
} // varphi(x) = (x + 1)e^(x^2)

let numOfStep = Int( ((to - from)/h).roundToDecimal(0) )

let TAB = "\t"

var phix = [Double](repeating: 0.0, count: numOfStep + 1)
var x = phix, y = phix, y_1 = phix, y_2 = phix

x[0] = x_0
y[0] = y_0
y_1[0] = y_0
y_2[0] = y_0
phix[0] = phi(x[0])

print("EULER")
print(
	"n" + TAB +
	"x_n" + TAB +
	"y_n" + TAB +
	"y_n (Euler cai tien 1)" + TAB +
	"y_n (Euler cai tien 2)" + TAB +
	"phi(x_n)"
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
		String(n) + TAB +
		String(x[n].roundToDecimal()) + TAB +
		String(y[n].roundToDecimal()) + TAB +
		String(y_1[n].roundToDecimal()) + TAB +
		String(y_2[n].roundToDecimal()) + TAB +
		String(phix[n].roundToDecimal())
	)
}
