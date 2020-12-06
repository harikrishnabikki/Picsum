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
    
    //MARK:- Network Call
    func getPicsum(pageNumber: Int = 1, success successBlock: @escaping (GetPicsumResponse) -> Void) {
        let builtUrl = "\("https://picsum.photos/v2/list?page=")\(String(pageNumber))\("&limit=100")" // building the url string for pagination
        guard let url = URL(string:builtUrl ) else { return }
        let request = URLRequest(url: url) // final url value
    
        
        session.dataTask(with: request) { (data, _, _) in 
            guard let data = data else { return }
            let responseString = NSString(data: data, encoding: String.Encoding.ascii.rawValue)
            let newResponseString = "\(  "{\"post\":") \(responseString ?? "https://raw.githubusercontent.com/harikrishnabikki/Picsum/main/Picsum/Data" ) \("}")"
            let dataValue = Data(newResponseString.utf8)
            do {
                guard let json = try? JSONSerialization.jsonObject(with: dataValue, options: []) as? JSON else { print("Exit"); return } // converting to JSON
                let getPicsumResponse = try GetPicsumResponse(json: json)
                DispatchQueue.main.async {
                    successBlock(getPicsumResponse)
                }
            } catch{
                print("Failed to load Data")
            }
        }.resume()
    }
    
    //MARK:- Download Image
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

