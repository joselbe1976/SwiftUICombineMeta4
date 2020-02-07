//
//  ViewModelImage.swift
//  SwiftUIMeta4FullBackend
//
//  Created by Jose Luis on 05/02/2020.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import SwiftUI
import Combine



final class loadEmployeeImage : ObservableObject {
    @Published var image = Image(systemName: "person.fill"){
        didSet{
            //print("Asignada Imagen nueva")
        }
    }
    
    var subscriber:AnyCancellable?
    
    func loadImage(idImage : String) {
        
            // if is in cache not access to Network
        
            if (ExistCacheFile(idFile: idImage)){
                let img : Data? = getCacheFile(idFile: idImage)
                DispatchQueue.main.async {
                    self.image = Image(uiImage: UIImage(data: img!)!)
                    print("Image of cache")
                }
                return
            }
        
            // not exist in cache
        
            print("Image of NetWork")
        
            let session = URLSession.shared
            let url = URL(string: "http://172.20.2.142:8100/REST/mfbcache?idapp=APP1&idclient=ios&idCache=\(idImage)")
        
            let request = NSMutableURLRequest(url: url!)
             // headers
             request.httpMethod = "GET"
             request.addValue("application/json", forHTTPHeaderField: "Content-Type")
             request.addValue("Basic Sk9TRUxCRToxMjM0NTY=", forHTTPHeaderField: "Authorization") // las credenciales a Meta4
        
        
            subscriber = session.dataTaskPublisher(for: request as URLRequest)
                .map {
                    let cad = String(data: $0.data, encoding: .windowsCP1252)!
                    return cad.data(using: .utf8)!
                }
                .decode(type: m4raiz.self, decoder: JSONDecoder())
                .map {
                    $0.m4.data(using: .utf8)!
                }
                .decode(type: m4image.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .map{
                    
                    let data = Data(base64Encoded: $0.file, options: .init(rawValue: 0))!  // String b64 -> Data
                    
                    // Save if not exist
                    if (!ExistCacheFile(idFile: idImage)){
                        InsertCacheFile(idFile: idImage, data: data)
                    }
                    return UIImage(data: data) //Data -> UIImage
                }
                .map { data -> Image in
                    Image(uiImage: data!)
                }
                .replaceEmpty(with: Image(systemName: "person.fill"))
                .replaceError(with: Image(systemName: "person.fill"))
                .eraseToAnyPublisher()
                .assign(to: \.image, on: self)
                   
    }
    
    
    // for design and Testing
    func setTestImage() -> Void{
        self.image = Image(systemName: "employee.fill")
    }
    
}
