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
    #if swift(>=3.0)
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


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
        // Put the code you want to measure the time of here.
        }
    }

    #else
    override func setUp() {
        super.setUp()
        NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys.forEach { key in
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        }
        NSUserDefaults.standardUserDefaults().synchronize()
        NSUserDefaults.standardUserDefaults().setObject("a", forKey: "Hoge-string")
        NSUserDefaults.standardUserDefaults().setObject(1, forKey: "Hoge-int")
        NSUserDefaults.standardUserDefaults().setObject("z", forKey: "Fuga-string")
        NSUserDefaults.standardUserDefaults().setObject(99, forKey: "Fuga-int")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInt() {
        let hoge = Hoge()
        XCTAssertEqual(hoge.int, NSUserDefaults.standardUserDefaults().integerForKey("Hoge-int"))
        hoge.int = 2
        XCTAssertEqual(hoge.int, NSUserDefaults.standardUserDefaults().integerForKey("Hoge-int"))
        NSUserDefaults.standardUserDefaults().setObject(3, forKey: "Hoge-int")
        XCTAssertEqual(hoge.int, NSUserDefaults.standardUserDefaults().integerForKey("Hoge-int"))
    }

    func testString() {
        let hoge = Hoge()
        XCTAssertEqual(hoge.string, NSUserDefaults.standardUserDefaults().stringForKey("Hoge-string"))
        hoge.string = "b"
        XCTAssertEqual(hoge.string, NSUserDefaults.standardUserDefaults().stringForKey("Hoge-string"))
        NSUserDefaults.standardUserDefaults().setObject("c", forKey: "Hoge-string")
        XCTAssertEqual(hoge.string, NSUserDefaults.standardUserDefaults().stringForKey("Hoge-string"))
    }
    #endif
    func testSeparate() {
        let hoge = Hoge()
        let fuga = Fuga()

        XCTAssertNotEqual(hoge.int, fuga.int)
    }

}
