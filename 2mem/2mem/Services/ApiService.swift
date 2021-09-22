//
//  ApiService.swift
//  2mem
//
//  Created by Artem Firsov on 9/21/21.
//

import Foundation
import Alamofire

class ApiService {
    
    let baseUrl = "https://api.unsplash.com/"
    let token = "1AoikOxOnE76wmkTiu0Fo32UmNO0T4e2Zjd3MxhBo_A"

    func getPhotos(searchTerm: String, completion: @escaping(SearchModel?) ->()) {
        let method = "/search/photos"
        let url = baseUrl + method
//        let header: HTTPHeaders = ["Autorization" : "Client-ID \(token)"]
        let parameters: Parameters = ["query": searchTerm,
                                      "page": String(1),
                                      "per_page": String(30),
                                      "client_id": token]
        
        AF.request(url, method: .get, parameters: parameters/*, headers: header*/).responseData { response in
            guard let data = response.data else { return }
            print(data.prettyJSON as Any)
            do {
            guard let photosResponse = try? JSONDecoder().decode(SearchModel.self, from: data) else { return }
                DispatchQueue.main.async {
                completion(photosResponse)
                }
            } catch {
                print(error)
              }
        }

    }
}
