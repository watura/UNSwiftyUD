//
//  UNSwiftyUDTests.swift
//  UNSwiftyUDTests
//
//  Created by Wataru Nishimoto on 2016/7/9.
//  Copyright © 2016 Wataru Nishimoto. All rights reserved.
//

import XCTest
@testable import UNSwiftyUD


class Hoge: UDBase {
    dynamic var string: String? = ""
    dynamic var int: Int = 0
}

class Fuga: UDBase {
    dynamic var string: String? = ""
    dynamic var int: Int = 0
}

class SwiftyUDTests: XCTestCase {

    override func setUp() {
        super.setUp()
        UserDefaults.standard.dictionaryRepresentation().keys.forEach { key in
            UserDefaults.standard.removeObject(forKey: key)
        }
        UserDefaults.standard.synchronize()
        UserDefaults.standard.set("a", forKey: "Hoge-string")
        UserDefaults.standard.set(1, forKey: "Hoge-int")
        UserDefaults.standard.set("z", forKey: "Fuga-string")
        UserDefaults.standard.set(99, forKey: "Fuga-int")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInt() {
        let hoge = Hoge()
        XCTAssertEqual(hoge.int, UserDefaults.standard.integer(forKey: "Hoge-int"))
        hoge.int = 2
        XCTAssertEqual(hoge.int, UserDefaults.standard.integer(forKey: "Hoge-int"))
        UserDefaults.standard.set(3, forKey: "Hoge-int")
        XCTAssertEqual(hoge.int, UserDefaults.standard.integer(forKey: "Hoge-int"))
    }

    func testString() {
        let hoge = Hoge()
        XCTAssertEqual(hoge.string, UserDefaults.standard.string(forKey: "Hoge-string"))
        hoge.string = "b"
        XCTAssertEqual(hoge.string, UserDefaults.standard.string(forKey: "Hoge-string"))
        UserDefaults.standard.set("c", forKey: "Hoge-string")
        XCTAssertEqual(hoge.string, UserDefaults.standard.string(forKey: "Hoge-string"))
    }

    func testSeparate() {
        let hoge = Hoge()
        let fuga = Fuga()

        XCTAssertNotEqual(hoge.int, fuga.int)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }    
}
