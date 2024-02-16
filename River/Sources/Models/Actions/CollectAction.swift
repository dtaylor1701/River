import Foundation

public struct CollectAction: Codable, Equatable {
    public let id: ID
  public let name: String
  public let outputArtifactID: ID
}

public extension CollectAction {
    func outputArtifact(in flow: Flow) throws -> Artifact {
        guard let artifact = flow.artifacts.first(where: { $0.id == outputArtifactID }) else {
            throw FlowError.undefinedArtifact
        }
        
        return artifact
    }
}
