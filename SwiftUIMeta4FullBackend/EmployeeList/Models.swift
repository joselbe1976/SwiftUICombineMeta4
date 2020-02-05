//
//  Models.swift
//  SwiftUIMeta4FullBackend
//
//  Created by Jose Luis on 03/02/2020.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import Foundation



struct employee : Decodable, Identifiable, Hashable{
    var id = UUID()
    var idrh:String
    var name:String
    var idphoto : String?
    var start : String?
    
    
    enum CodingKeys: String, CodingKey {
        case idrh
        case name
        case idphoto
        case start
    }
}

struct meta4Data : Decodable {
    var employees : [employee]?
    enum CodingKeys: String, CodingKey {
        case employees
        
    }
}

struct meta4 : Decodable{
    var records : String
    var data : meta4Data
    enum CodingKeys: String, CodingKey {
        case data
        case records
    }
}



// ----- Image ----


struct m4image : Decodable{
    var ext : String //extension file
    var file : String // in base64
    enum CodingKeys: String, CodingKey {
        case ext
        case file
    }
}

// ------ Common -------

struct m4raiz : Decodable{
    var m4 : String
}





