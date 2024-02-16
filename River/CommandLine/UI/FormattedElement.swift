struct FormattedElement {
  private let space = " "
  let value: String
  let children: [FormattedElement]

  init(_ value: String, @FormattedOutputBuilder children: () -> [FormattedElement]) {
    self.value = value
    self.children = children()
  }

  init(_ value: String) {
    self.init(value, children: {})
  }

  func formattedOutput(level: Int = 0) -> String {
    let nextLevel = level + 1
    var output = "\n" + String(repeating: space, count: level)
    output.append(value)
    for child in children {
      output.append(child.formattedOutput(level: nextLevel))
    }
    return output
  }

  static func spacer() -> FormattedElement {
    FormattedElement("")
  }
}

extension Array where Element == FormattedElement {
  func formattedOutput() -> String {
    self.map { $0.formattedOutput() }.joined(separator: "")
  }
}

@resultBuilder
struct FormattedOutputBuilder {
  static func buildBlock() -> [FormattedElement] {
    []
  }

  static func buildBlock(_ components: [FormattedElement]) -> [FormattedElement] {
    components
  }

  static func buildBlock(_ components: [FormattedElement]...) -> [FormattedElement] {
    components.flatMap { $0 }
  }

  static func buildOptional(_ component: [FormattedElement]?) -> [FormattedElement] {
    component ?? []
  }

  static func buildArray(_ components: [[FormattedElement]]) -> [FormattedElement] {
    components.flatMap { $0 }
  }

  static func buildEither(first component: [FormattedElement]) -> [FormattedElement] {
    component
  }

  static func buildEither(second component: [FormattedElement]) -> [FormattedElement] {
    component
  }

  static func buildExpression(_ expression: FormattedElement) -> [FormattedElement] {
    [expression]
  }

  static func buildExpression(_ expression: [FormattedElement]) -> [FormattedElement] {
    expression
  }
}

func makeOutput(@FormattedOutputBuilder _ content: () -> [FormattedElement]) -> [FormattedElement] {
  content()
}
