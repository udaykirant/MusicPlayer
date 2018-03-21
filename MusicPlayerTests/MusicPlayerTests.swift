//
//  MusicPlayerTests.swift
//  MusicPlayerTests
//
//  Created by Uday Kiran on 14/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import XCTest
@testable import MusicPlayer

class MusicPlayerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAPICall() {
        let success = expectation(description: "SongsListAPI Success")
        APIClient.getRequestWithURL(Constants.SongsListAPI) { (data, error) in
            if let _error = error {
                XCTFail(_error.localizedDescription)
            } else if let _ = data {
                success.fulfill()
            } else {
                XCTFail("Invalid URL")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testInvalidAPIEndPoint() {
        let success = expectation(description: "API Failure case")
        APIClient.getRequestWithURL("testfailurecase") { (data, error) in
            if let _ = error {
                success.fulfill()
            }
            if let _ = data {
                XCTFail("test should fail because of invalid data")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testInvalidURL() {
        let success = expectation(description: "Invalid URL  case")
        APIClient.getRequestWithURL("test failurecase") { (data, error) in
            if let _ = error, let _ = data {
                 XCTFail("test should fail because of invalid URL")
            } else {
                success.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSognsListInteractor() {
        let success = expectation(description: "song model objects creation successful ")
        let interator = SongsListInteractor()
        interator.getSongsList { (songs, error) in
            if let _error = error {
                XCTFail(_error.localizedDescription)
            }
            
            if songs.count > 0 {
                success.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCompareSongObjects() {
        guard let dummyURL = URL(string: "www.google.com") else { XCTFail("Invalid URL"); return }
        let picture = Picture(small: dummyURL, medium: dummyURL, large: dummyURL, extraSmall: dummyURL, url: dummyURL)
        let author = Author(name: "", picture: picture)
        let song1 = Song(id: "1", name: "test1", audioLink: dummyURL, createdOn: Date(), modifiedOn: Date(), picture:picture, author:author)
        let song2 = Song(id: "2", name: "test2", audioLink: dummyURL, createdOn: Date(), modifiedOn: Date(), picture:picture, author:author)
        if song1 == song2 {
            XCTFail("Invalid song comparision")
        }
    }
    
    func testImageDownload() {
        let imageDownload = expectation(description: "download image success")
        guard let imageURL = URL(string: "https://bandlab-test-images.azureedge.net/v1.0/users/71c81538-4e88-e511-80c6-000d3aa03fb0/636016633463395803") else { XCTFail("Invalid URL"); return }
        let imageView = UIImageView()
        imageView.loadImage(fromURL: imageURL) { (success) in
            if imageView.image != nil {
                imageDownload.fulfill()
            }
        }
        waitForExpectations(timeout: 5) { (error) in
            let imageView2 = UIImageView()
            imageView2.loadImage(fromURL: imageURL) { (success) in
                if imageView2.image == nil {
                    XCTFail("Image Cache failed")
                }
            }
        };
    }
    
    func testImageDownloadWithInvalidURL() {
        let imageDownloadFailure = expectation(description: "Invalid imageurl should fail")
        guard let imageURL = URL(string: "invalidURL") else { XCTFail("Invalid URL"); return }
        let imageView = UIImageView()
        imageView.loadImage(fromURL: imageURL) { (success) in
            if !success {
                imageDownloadFailure.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPlayerViewInitialization() {
        guard let _ = PlayerView().loadNib(withName: String(describing: PlayerView.self)) as? PlayerView else {
           XCTFail("PlayerView  Initialization failed")
            return
        }
        XCTAssert(true, "PlayerView  Initialized")
    }
    
    func testFloatToString() {
       var result = ""
       result = result.readableTimeFormat(forDuration: 60)
       XCTAssert(result == "01:00", "readable TimeFormat")
        result = result.readableTimeFormat(forDuration: 3600)
        XCTAssert(result == "01:00:00", "readable TimeFormat")
    }
    
    func testDatesDifference() {
        var date = Date().addingTimeInterval(-1)
        var dateString = date.differenceWithCurrentDate()
        XCTAssert((dateString == "1 sec ago"), "readable date Format")
        
        date = Date().addingTimeInterval(-60)
        dateString = date.differenceWithCurrentDate()
        XCTAssert((dateString == "1 min ago"), "readable date Format")
        
        date = Date().addingTimeInterval(-120)
        dateString = date.differenceWithCurrentDate()
        XCTAssert((dateString == "2 mins ago"), "readable date Format")
        
        date = Date().addingTimeInterval(-(60 * 60))
        dateString = date.differenceWithCurrentDate()
        XCTAssert((dateString == "1 hour ago"), "readable date Format")
        
        date = Date().addingTimeInterval(-(60 * 60 * 2))
        dateString = date.differenceWithCurrentDate()
        XCTAssert((dateString == "2 hours ago"), "readable date Format")
        
        date = Date().addingTimeInterval(-(60 * 60 * 24))
        dateString = date.differenceWithCurrentDate()
        XCTAssert((dateString == "1 day ago"), "readable date Format")
        
        date = Date().addingTimeInterval(-(60 * 60 * 48))
        dateString = date.differenceWithCurrentDate()
        XCTAssert((dateString == "2 days ago"), "readable date Format")
       
        date = Date().addingTimeInterval(-(60 * 60 * 24 * 31))
        dateString = date.differenceWithCurrentDate()
        XCTAssert((dateString == "1 month ago"), "readable date Format")
        
        date = Date().addingTimeInterval(-(60 * 60 * 24 * 60))
        dateString = date.differenceWithCurrentDate()
        XCTAssert((dateString == "2 months ago"), "readable date Format")
        
        date = Date().addingTimeInterval(-(60 * 60 * 24 * 365))
        dateString = date.differenceWithCurrentDate()
        XCTAssert((dateString == "1 year ago"), "readable date Format")
        
        date = Date().addingTimeInterval(-(60 * 60 * 24 * 365 * 2))
        dateString = date.differenceWithCurrentDate()
        XCTAssert((dateString == "2 years ago"), "readable date Format")
        
        date = Date().addingTimeInterval((60))
        dateString = date.differenceWithCurrentDate()
        XCTAssert((dateString == ""), "comparing with future dates")
    }
}
