import UIKit

var colorSet: Set = Set<String>()
var colorArray: [String] = []
var colorDict: Dictionary<Character, String> = [:]

var colorBlue: String

colorBlue = "Blue"

colorSet.insert(colorBlue)
colorArray.append(colorBlue)
colorDict["R"] = "Red"

enum Color {
    case Red
    case Green
    case Blue
}

Color.Blue
