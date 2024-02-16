import Foundation

public enum Action: Codable, Equatable {
  case collect(_ action: CollectAction)
  case execute(_ action: ExecuteAction)

  public var outputArtifactID: ID {
    switch self {
    case .collect(let action):
      return action.outputArtifactID
    case .execute(let action):
      return action.outputArtifactID
    }
  }

  public var name: String {
    switch self {
    case .collect(let action):
      return action.name
    case .execute(let action):
      return action.name
    }
  }
    
    func outputArtifact(in flow: Flow) throws -> Artifact {
        guard let artifact = flow.artifacts.first(where: { $0.id == outputArtifactID }) else {
            throw FlowError.undefinedArtifact
        }
        
        return artifact
    }
}

