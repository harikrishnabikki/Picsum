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
    private let limit = 10
    let session = URLSession.shared
    
    
    func getPicsum(pageNumber: Int = 1, shouldPage:Bool = false, success successBlock: @escaping (GetPicsumResponse) -> Void) {
        let builtUrl = "\("https://picsum.photos/v2/list?page=")\(String(pageNumber))\("&limit=100")"
        guard let url = URL(string:builtUrl ) else { return }
        let request = URLRequest(url: url)
    
        
        session.dataTask(with: request) { (data, _, _) in
            guard let data = data else { return }
            let responseString = NSString(data: data, encoding: String.Encoding.ascii.rawValue)
            let newResponseString = "\(  "{\"post\":") \(responseString ?? "https://raw.githubusercontent.com/harikrishnabikki/Picsum/main/Picsum/Data" ) \("}")"
            let dataValue = Data(newResponseString.utf8)
            do {
                guard let json = try? JSONSerialization.jsonObject(with: dataValue, options: []) as? JSON else { print("Exit"); return }
                let getPicsumResponse = try GetPicsumResponse(json: json)
                DispatchQueue.main.async {
                    successBlock(getPicsumResponse)
                }
            } catch{
                print("Failed to load Data")
            }
        }.resume()
    }
    
    
    func downloadImage(fromLink link: String, success successBlock: @escaping (UIImage) -> Void) {
        guard let url = URL(string: link) else { return }
        session.dataTask(with: url) { (data, _, _) in
            guard let data = data,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                successBlock(image)
            }
        }.resume()
    }
}

