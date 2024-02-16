import Foundation

public struct Artifact: Codable, Equatable {
  public enum Content: String, Codable {
    case text
    case url
    case bool
    case number
  }
    public var id: ID
  public var description: String
  public var fileName: String
  public var contentType: Content
}
