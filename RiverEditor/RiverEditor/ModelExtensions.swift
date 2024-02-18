import Foundation
import RiverKit

extension Flow: Identifiable {}
extension Action: Identifiable {
  public var id: String {
    switch self {
    case .collect(let action):
      return action.id
    case .execute(let action):
      return action.id
    }
  }
}
extension Step: Identifiable {}
extension Artifact: Identifiable {}
extension Artifact.Content: Identifiable {
  public var id: String {
    rawValue
  }
  
  var displayValue: String {
    switch self {
    case .bool:
      return "Boolean"
    case .number:
      return "Number"
    case .text:
      return "Text"
    case .url:
      return "URL"
    }
  }
}

extension String: Identifiable {
  public var id: String {
    self
  }
}
