//
//  StepsView.swift
//  RiverEditor
//
//  Created by David Taylor on 11/22/23.
//

import Foundation
import SwiftUI
import RiverKit

struct StepsView: View {
    @Binding
    var steps: [StoredStep]
    
    @Binding
    var selected: StoredStep?
    
    var body: some View {
        List {
            ForEach(steps, id: \.id) { step in
                Button {
                    selected = step
                } label: {
                    StepCard(step: step)
                }
            }
        }
    }
}

struct StepCard: View {
    let step: StoredStep
    
    var body: some View {
        Text(step.name)
    }
}
