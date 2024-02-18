import Foundation
import SwiftUI
import RiverKit

struct StepsView: View {
  @Binding
  var steps: [Step]
  
  @Binding
  var selected: Step?
  
  var body: some View {
    List {
      ForEach(steps) { step in
        Button {
          selected = step
        } label: {
          StepCard(step: step)
            .asListButtonContent(isSelected: step == selected)
        }
        .buttonStyle(.plain)
      }
    }
  }
}

struct StepCard: View {
  let step: Step
  
  var body: some View {
      Text(step.name)
  }
}
