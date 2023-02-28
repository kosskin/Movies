// Movies_MVVMUITestsLaunchTests.swift
// Copyright © Koskin VA. All rights reserved.

import XCTest

/// UI Launch tests
final class Movies_MVVMUITestsLaunchTests: XCTestCase {
    // MARK: Public Properties
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    
    // MARK: - Public Methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
