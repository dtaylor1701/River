import Foundation

public struct Flow {
  public var id: UUID
  public var name: String
  public var steps: [Step]
}

public struct Step {
  public var id: UUID
  public var name: String
}
