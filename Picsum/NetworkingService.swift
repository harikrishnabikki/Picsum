//
//  NetworkingService.swift
//  Picsum
//
//  Created by Hari Krishna Bikki on 4/12/20.
//

import UIKit


typealias JSON = [String: Any]

class NetworkingService {
    
    static let shared = NetworkingService()
    private init() {}
    
    let session = URLSession.shared
    
    func getPicsum(success successBlock: @escaping (GetPicsumResponse) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/harikrishnabikki/Zinq-Code-Test-v3/master/data.json") else { return }
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { (data, _, _) in
            guard let data = data else { return }
            do {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? JSON else { return }
                let getPicsumResponse = try GetPicsumResponse(json: json)
                DispatchQueue.main.async {
                    successBlock(getPicsumResponse)
                }
            } catch{
                print("Failed to load: ")
            }
        }.resume()
    }
}

