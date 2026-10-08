import Domain
import Foundation

extension WineColor {
  var displayNameKey: String.LocalizationValue {
    switch self {
    case .red: "wineColor.red"
    case .white: "wineColor.white"
    case .rosado: "wineColor.rosado"
    }
  }
}
