//
//  MCUTests.swift
//  MCUTests
//
//  Created by 홍성준 on 2021/10/21.
//

import XCTest
@testable import MCU

class RepositoryTestCase: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Repository_fecthData() throws {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: Date())
        var compareMcu: Mcu?
        
        // 예상치 못한 URL이 들어왔을 때 Nil
        Repository.shared.fecthData("123123123") { mcu in
            XCTAssertNil(mcu)
        }
        
        // API 가 가지고 있는 날짜 범위를 초과하였을 때 Nil
        Repository.shared.fecthData("2999-01-01") { mcu in
            XCTAssertNil(mcu)
        }
        
        // Base URL 에서 데이터를 호출하였을 때
        Repository.shared.fecthData("") { mcu  in
            compareMcu = mcu
        }
        
        // 현재 시간으로 URL 을 호출하였을 때
        // Base URL 에서 호출했을 때와 값이 같아야함
        Repository.shared.fecthData(date) { mcu in
            guard let mcu = mcu else {
                XCTFail()
                return
            }
            
            guard let compareMcu = compareMcu else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(mcu, compareMcu)
        }
        
        let baseUrl = "https://www.whenisthenextmcufilm.com/api"
        
        // Base URL 을 기본적으로 설정하였는데
        // 추가로 또 Base URL이 주어졌을 때 (Prefix 에 http 존재 유무로 파악)
        // 정상적으로 작동하는 지 파악
        // fecthData("") 와 fetchData(baseUrl) 이 같은 값을 내보내는 지 테스트
        Repository.shared.fecthData(baseUrl) { mcu in
            guard let mcu = mcu else {
                XCTFail()
                return
            }
            guard let compareMcu = compareMcu else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(mcu, compareMcu)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
