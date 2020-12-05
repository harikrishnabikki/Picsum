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
        guard let url = URL(string: "https://raw.githubusercontent.com/harikrishnabikki/Picsum/main/Picsum/Data?token=AE3REHU5XFQNGLT4IKZYP7K7ZLKD6") else { return }
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { (data, _, _) in
            guard let data = data else { return }

            print(type(of:data))
            
            do {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? JSON else { print("Empty");  return }
                print(json)
                print(type(of:json))
                
                
//                do {
//                    if let result = try JSONDecoder().decode([API].self, from: data).first {
//                        print(result.id ?? 22)
//                        print(result.author ?? "Sample")
//                    }
//
//                } catch {
//                    print(error)
//                }

                
                
               // let getPicsumResponse = try GetPicsumResponse(json: json)
               // successBlock(getPicsumResponse)
            } catch{
                print("Failed to load: ")
            }
        }.resume()
    }
}
