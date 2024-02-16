import Foundation

public typealias ID = String

// Definitions

public struct Flow: Codable, Equatable {
    public var id: ID
    public var name: String
    public var steps: [Step]
    public var artifacts: [Artifact]
    
    public init(id: ID, name: String, steps: [Step], artifacts: [Artifact]) {
        self.id = id
        self.name = name
        self.steps = steps
        self.artifacts = artifacts
    }
}

extension Flow {
    public static func dummy() -> Flow {
        let breadArtifact = Artifact(id: UUID().uuidString, description: "Bread", fileName: "bread", contentType: .text)
        let peanutButterArtifact = Artifact(id: UUID().uuidString,
            description: "Peanut butter", fileName: "peanut butter", contentType: .text)
        let jamArtifact = Artifact(id: UUID().uuidString, description: "Jam", fileName: "jam", contentType: .text)
        
        let getBreadAction = CollectAction(id: UUID().uuidString, name: "Get Bread", outputArtifactID: breadArtifact.id)
        let getPeanutButtonAction = CollectAction(id: UUID().uuidString,
                                                  name: "Get Peanut Butter", outputArtifactID: peanutButterArtifact.id)
        let getJamAction = CollectAction(id: UUID().uuidString, name: "GetJamArtifact", outputArtifactID: jamArtifact.id)
        
        let gatherIngredientsStep = Step(
            id: UUID().uuidString,
            name: "Gather ingredients",
            dependencyIDs: [],
            actions: [.collect(getBreadAction), .collect(getPeanutButtonAction), .collect(getJamAction)])
        
        let sandwichArtifact = Artifact(id: UUID().uuidString,
            description: "The assembled ingredients",
            fileName: "sandwich",
            contentType: .text)
        let assembleSandwichStep = Step(
            id: UUID().uuidString,
            name: "Assemble sandwich",
            dependencyIDs: [breadArtifact.id, peanutButterArtifact.id, jamArtifact.id],
            actions: [
                .execute(
                    ExecuteAction(
                        id: UUID().uuidString,
                        name: "Assemble",
                        executablePath: "/Users/david/Developer/River/River/assemble.sh",
                        arguments: [],
                        outputArtifactID: sandwichArtifact.id))
            ])
        
        return Flow(
            id: UUID().uuidString,
            name: "Make PB&J",
            steps: [
                gatherIngredientsStep,
                assembleSandwichStep,
            ],
        artifacts: [breadArtifact, 
                    peanutButterArtifact,
                    jamArtifact,
                    sandwichArtifact])
    }
}
