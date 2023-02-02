//
//  NetworkControllerTests.swift
//  NetworkControllerTests
//
//  Created by Tong Wang on 2/2/23.
//

import XCTest

final class NetworkControllerTests: XCTestCase {
    
    private var sut:NetworkController!
    
    override func setUpWithError() throws {
        sut = NetworkController()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
 
    func testGrouping () {
        let expectation = XCTestExpectation(description: "Get Dictionary")

        sut.retrieveData { itemsByListid in
            let listDict = itemsByListid
            
            for (listId, items) in listDict {
                for item in items {
                    XCTAssertEqual(item.listId, listId)
                }
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFilter () {
        let expectation = XCTestExpectation(description: "Get Dictionary")
        
        sut.retrieveData { itemsByListid in
            
            let listDict = itemsByListid

            for (_, items) in listDict{
                for item in items {
                    XCTAssertNotEqual(item.name, "")

                }
            }

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSorted () {
        let expectation = XCTestExpectation(description: "Get Dictionary")
        
        sut.retrieveData { itemsByListid in
            
            let listDict = itemsByListid
            for (_, items) in listDict {
                for i in 0...items.count-2 {
                    // Used the trait that name for an item is always Item + id
                    XCTAssertLessThanOrEqual(items[i].id, items[i+1].id)
                }
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    

}
