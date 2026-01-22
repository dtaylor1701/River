import Foundation

public struct CollectAction: Codable, Equatable {
  public let id: ID
  public var name: String
  public var description: String
  public var outputArtifactID: ID
  
  public init(id: ID = UUID().uuidString,
              name: String,
              description: String,
              outputArtifactID: ID) {
    self.id = id
    self.name = name
    self.description = description
    self.outputArtifactID = outputArtifactID
  }
}

public extension CollectAction {
  func outputArtifact(in flow: Flow) throws -> Artifact {
    guard let artifact = flow.artifacts.first(where: { $0.id == outputArtifactID }) else {
      throw FlowError.undefinedArtifact
    }
    
    return artifact
  }
}
