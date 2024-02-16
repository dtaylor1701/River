import Foundation

public struct Step: Codable, Equatable {
    public var id: ID
    public var name: String
    public var dependencyIDs: [ID]
    public var actions: [Action]
}

extension Step {
    func dependencies(in flow: Flow) throws -> [Artifact] {
        try dependencyIDs.map { artifactID in
            guard let artifact = flow.artifacts.first(where: { $0.id == artifactID}) else {
                throw FlowError.undefinedArtifact
            }
            
            return artifact
        }
    }
}

