//
//  StreamAnalyticsSwiftTests.swift
//  StreamAnalytics
//
//  Created by Alexander van der Werff on 07/09/15.
//  Copyright (c) 2015 Stream. All rights reserved.
//

import UIKit
import XCTest

class StreamAnalyticsSwiftTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testStreamAnalyticsSingletonExists() {
        XCTAssertNotNil(StreamAnalytics.sharedInstance(), "StreamAnalytics singleton class exists")
    }

    func testTrackImpressionEventCallback() {
        let expectation:XCTestExpectation = self.expectation(description: "Track async impression event")
        let event = StreamImpression.createImpressionEvent(withContentList: ["id1", "id2"])

        StreamAnalytics.sharedInstance().setUserId("dude");
        StreamAnalytics.sharedInstance().send(event, completionHandler: { (statusCode, json, error) -> Void in
            
            print("response with status code: \(statusCode)")
            XCTAssertNil(error, "\(error)")
            XCTAssertTrue(statusCode==201, "event not created on server")
            expectation.fulfill()
            
        })
        
        waitForExpectations(timeout: 10, handler: { (error) -> Void in
            XCTAssertNil(error)
        })

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }

}
