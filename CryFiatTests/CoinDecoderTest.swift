//
//  CoinDecoderTest.swift
//  CryFiatTests
//
//  Created by Jan Miklas on 17.06.2021.
//

import XCTest
@testable import CryFiat

class CoinDecoderTest: XCTestCase {


    func testCanDecodeCoinsFpromJsonFile() throws {
        guard let jsonPath = Bundle(for: type(of: self)).path(forResource: "coins", ofType: "json") else {
            fatalError("json file not found")
        }
        
        let jsonString = try? String(contentsOfFile: jsonPath)
        
        let jsonData = jsonString!.data(using: .utf8)
        let coinsData = try! JSONDecoder().decode([CoinsTokenMarket].self, from: jsonData!)
        
        XCTAssertEqual("yooshi", coinsData[29].id)
        XCTAssertEqual(0.120991, coinsData[0].currentPrice)
        XCTAssertEqual("https://assets.coingecko.com/coins/images/8370/large/xAFGD7BZ_400x400.jpg?1557804634", coinsData.last!.image)
        XCTAssertEqual(5.57, coinsData[11].ath!)
        XCTAssertEqual(0.01031732, coinsData[20].currentPrice)
    }
}
