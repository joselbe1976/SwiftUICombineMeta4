//
//  network.swift
//  SwiftUIMeta4FullBackend
//
//  Created by Jose Luis on 03/02/2020.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import SwiftUI
import Combine


final class loadDataEmployees : ObservableObject {
    @Published var m4dataEmployees = [employee](){
        didSet{
            print("Asignado valor a empleados!!!!! \(self.m4dataEmployees.count)")
        }
    }
    
    
    init(){
              self.loadData()
    }
    
    
    var subscriber:AnyCancellable?
    
    func loadData() {
            let session = URLSession.shared
            let url = URL(string: "http://172.20.2.142:8100/REST/mfbdemo?idapp=APP1&idclient=ios&offset=4&filter=&begin=0")
        
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
                .decode(type: meta4.self, decoder: JSONDecoder())
                .map{
                    $0.data.employees!
                }
                .replaceEmpty(with: [employee]())
                .replaceError(with: [employee]())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
                .assign(to: \.m4dataEmployees, on: self)
                   
    }
    
    
    // for design and Testing
    func testData() -> employee{
        employee(idrh: "10010", name: "Jose Luis Bustos", idphoto: "PHOTO-0001-M100492", start: "01/01/2010")
    }
    
}
