//
//  Session.swift
//  Reciplease
//
//  Created by Thibault Ballof on 31/05/2022.
//

import Foundation
import Alamofire

final class RecipeSession: SessionProtocol {
    func request(url: URL, callback: @escaping (AFDataResponse<RecipeData>) -> Void) {
        AF.request(url).responseDecodable(of: RecipeData.self) { dataResponse in
            callback(dataResponse)
        }
    }
    
}
