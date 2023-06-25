//
//  Unit_test_SampleTests.swift
//  Unit test SampleTests
//
//  Created by 문상우 on 2023/06/23.
//

import XCTest
@testable import Unit_test_Sample

final class Unit_test_SampleTests: XCTestCase {
    
    var sut: LoginValidator!

    override func setUpWithError() throws {
        sut = LoginValidator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testEven() {
        let number = Even(number: 1020)
        XCTAssertTrue(number.isEven)
    }
    
    func testOdd() {
        let number = Even(number: 1021)
        XCTAssertTrue(!number.isEven)
    }
    
    func testLoginValue() {
        let user = User(email: "test@test.com", password: "1234")
        let isValidEmail = sut.isVaildEmail(email: user.email)
        
        XCTAssertTrue(isValidEmail)
    }

}
