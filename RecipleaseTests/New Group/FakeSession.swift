//
//  FakeSession.swift
//  RecipleaseTests
//
//  Created by Thibault Ballof on 31/05/2022.
//

import Foundation
import Alamofire
@testable import Reciplease

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
    var result: Result<RecipeData, AFError>
}

final class FakeSession: SessionProtocol {
    // MARK: - Properties
    private let fakeResponse: FakeResponse

    // MARK: - Initializer
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }

    // MARK: - Methods
    func request(url: URL, callback: @escaping (AFDataResponse<RecipeData>) -> Void) {
        let dataResponse = AFDataResponse<RecipeData>(request: nil, response: fakeResponse.response, data: fakeResponse.data, metrics: nil, serializationDuration: 0, result: fakeResponse.result)
        callback(dataResponse)
    }
}

