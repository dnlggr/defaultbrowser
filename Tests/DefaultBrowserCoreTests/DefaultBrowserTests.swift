import XCTest
@testable import DefaultBrowserCore

final class DefaultBrowserTests: XCTestCase {
    let safari = DefaultBrowser(bundleId: "com.apple.Safari")
    let firefox = DefaultBrowser(bundleId: "org.mozilla.firefox")
    let tor = DefaultBrowser(bundleId: "org.mozilla.tor browser")
    let chrome = DefaultBrowser(bundleId: "com.google.Chrome")

    func testBrowserEquality() {
        XCTAssertEqual(safari, safari)
        XCTAssertEqual(firefox, firefox)
        XCTAssertEqual(tor, tor)
        XCTAssertEqual(chrome, chrome)

        XCTAssertNotEqual(safari, firefox)
        XCTAssertNotEqual(firefox, tor)
        XCTAssertNotEqual(tor, chrome)
        XCTAssertNotEqual(chrome, safari)
    }

    func testBrowserNames() throws {
        XCTAssertEqual(safari.name, "safari")
        XCTAssertEqual(firefox.name, "firefox")
        XCTAssertEqual(tor.name, "tor browser")
        XCTAssertEqual(chrome.name, "chrome")
    }

    func testBrowserList() {
        let browsers = DefaultBrowser.all

        XCTAssertTrue(browsers.contains(safari))
    }

    func testDefaultBrowser() {
        // This assumes 'safari' is the default browser.
        XCTAssertEqual(DefaultBrowser.current, safari)
    }

    func testSettingBrowser() {
        // This is hard to test since there's a user dialog involved.
    }
}
