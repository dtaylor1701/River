import Foundation

extension FileManager {
  func fileExists(atPath path: URL) -> Bool {
    guard let path = path.path().removingPercentEncoding else {
      return false
    }
    return fileExists(atPath: path)
  }
}
