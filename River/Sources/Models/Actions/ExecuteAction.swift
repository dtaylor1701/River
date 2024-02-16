import Foundation

public struct ExecuteAction: Codable, Equatable {
    public let id: ID
  public let name: String
  public let executablePath: String
  public let arguments: [String]
  public let outputArtifactID: ID
}

public extension ExecuteAction {
    func outputArtifact(in flow: Flow) throws -> Artifact {
        guard let artifact = flow.artifacts.first(where: { $0.id == outputArtifactID }) else {
            throw FlowError.undefinedArtifact
        }
        
        return artifact
    }
}
