#if canImport(UIKit)
import XCTest
import UIKit
@testable import Fashion

final class UIViewStyleableTests: XCTestCase {
  var label: UILabel!

  override func setUp() {
    super.setUp()

    label = .init()
    label.backgroundColor = .red
    label.textColor = .white
    label.numberOfLines = 2

    Stylist.master.register("label-1") { (label: UILabel) in
      label.textColor = .red
      label.numberOfLines = 10
    }

    Stylist.master.register("label-2") { (label: UILabel) in
      label.backgroundColor = .yellow
      label.numberOfLines = 3
    }
  }

  override func tearDown() {
    Stylist.master.styles.removeAll()
    Stylist.master.sharedStyles.removeAll()
    super.tearDown()
  }

  func testInitFrameStyles() {
    // It applies styles
    label = UILabel(styles: "label-1 label-2")

    XCTAssertEqual(label.backgroundColor, .yellow)
    XCTAssertEqual(label.textColor, .red)
    XCTAssertEqual(label.numberOfLines, 3)
  }

  func testApplyStylesWithRegisteredStyles() {
    // It applies previously registered styles
    label.apply(styles: "label-1", "label-2")

    XCTAssertEqual(label.backgroundColor, .yellow)
    XCTAssertEqual(label.textColor, .red)
    XCTAssertEqual(label.numberOfLines, 3)
  }

  func testApplyStylesAsArrayWithRegisteredStyles() {
    // It applies previously registered styles
    label.apply(styles: ["label-1", "label-2"])

    XCTAssertEqual(label.backgroundColor, .yellow)
    XCTAssertEqual(label.textColor, .red)
    XCTAssertEqual(label.numberOfLines, 3)
  }

  func testApplyStylesWithNotRegisteredStyles() {
    // It does not apply not registered styles
    label.apply(styles: "label-3", "label-4")

    XCTAssertEqual(label.backgroundColor, .red)
    XCTAssertEqual(label.textColor, .white)
    XCTAssertEqual(label.numberOfLines, 2)
  }

  func testApplyStylesAsArrayWithNotRegisteredStyles() {
    // It does not apply not registered styles
    label.apply(styles: ["label-3", "label-4"])

    XCTAssertEqual(label.backgroundColor, .red)
    XCTAssertEqual(label.textColor, .white)
    XCTAssertEqual(label.numberOfLines, 2)
  }

  func testStylesGetter() {
    // It returns a style that has been previously set
    label.styles = "label-1"
    XCTAssertEqual(label.styles, "label-1")
  }

  func testStylesWithSingleRegisteredStyle() {
    // It applies previously registered style"
    label.styles = "label-1"

    XCTAssertEqual(label.backgroundColor, .red)
    XCTAssertEqual(label.textColor, .red)
    XCTAssertEqual(label.numberOfLines, 10)
  }

  func testStylesWithSingleNotRegisteredStyle() {
    // It  does not apply not registered style
    label.styles = "label-3 label-4"

    XCTAssertEqual(label.backgroundColor, .red)
    XCTAssertEqual(label.textColor, .white)
    XCTAssertEqual(label.numberOfLines, 2)
  }

  func testStylesWithMultipleRegisteredStyles() {
    // It  applies previously registered styles
    label.styles = "label-1 label-2"

    XCTAssertEqual(label.backgroundColor, .yellow)
    XCTAssertEqual(label.textColor, .red)
    XCTAssertEqual(label.numberOfLines, 3)
  }

  func testStylesWithMultipleNotRegisteredStyle() {
    // It  does not apply not registered styles
    label.styles = "label-3 label-4"

    XCTAssertEqual(label.backgroundColor, .red)
    XCTAssertEqual(label.textColor, .white)
    XCTAssertEqual(label.numberOfLines, 2)
  }
}
#endif
