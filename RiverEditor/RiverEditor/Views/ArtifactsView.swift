//
//  ArtifactsView.swift
//  RiverEditor
//
//  Created by David Taylor on 11/22/23.
//

import Foundation
import SwiftUI
import RiverKit

struct ArtifactsView: View {
    @Binding
    var artifacts: [StoredArtifact]
    
    @Binding
    var selected: StoredArtifact?
    
    var body: some View {
        List {
            ForEach(artifacts, id: \.fileName) { artifact in
                Button {
                    selected = artifact
                } label: {
                    ArtifactCard(artifact: artifact)

                }
            }
        }
    }
}

struct ArtifactCard: View {
    let artifact: StoredArtifact
    
    var body: some View {
        Text(artifact.fileName)
    }
}
