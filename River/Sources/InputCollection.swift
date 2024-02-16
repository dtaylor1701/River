import Foundation

public enum InputCollection {
  static let validTrueInput: Set<String> = ["true", "yes", "y", "1"]
  static let validFalseInput: Set<String> = ["false", "no", "n", "0"]

  static func boolValue(_ string: String) -> Bool? {
    let cleaned = string.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    if validTrueInput.contains(cleaned) {
      return true
    } else if validFalseInput.contains(cleaned) {
      return false
    }

    return nil
  }
}
