//
//  SessionProtocol.swift
//  Reciplease
//
//  Created by Thibault Ballof on 31/05/2022.
//

import Foundation
import Alamofire

protocol SessionProtocol {
    func request(url: URL, callback: @escaping (AFDataResponse<RecipeData>) -> Void)
}
