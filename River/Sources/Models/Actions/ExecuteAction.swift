import Foundation

public struct ExecuteAction: Codable, Equatable {
  public let id: ID
  public var name: String
  public var executablePath: String
  public var arguments: [String]
  public var outputArtifactID: ID
  
  public init(id: ID = UUID().uuidString, name: String, executablePath: String, arguments: [String], outputArtifactID: ID) {
    self.id = id
    self.name = name
    self.executablePath = executablePath
    self.arguments = arguments
    self.outputArtifactID = outputArtifactID
  }
}

public extension ExecuteAction {
  func outputArtifact(in flow: Flow) throws -> Artifact {
    guard let artifact = flow.artifacts.first(where: { $0.id == outputArtifactID }) else {
      throw FlowError.undefinedArtifact
    }
    
    return artifact
  }
}
