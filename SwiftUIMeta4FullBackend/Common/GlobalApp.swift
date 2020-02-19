//
//  DefaultData.swift
//  SwiftUIMeta4FullBackend
//
//  Created by Jose Luis on 07/02/2020.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import SwiftUI



struct GlobalParams {
    let idMeta4App : String = "APP1"
    let idMeta4Client : String = "ios"
    let offSetGlobal : Int = 20  // offset global por defecto
    let adminCredential : String = "Basic Sk9TRUxCRToxMjM0NTY=" // Credencial administradora
    let api : String = "http://172.20.2.131:8003/REST/" // URL API de Meta4
}


enum Paths : String {
    case Login = "mfbsession"
    case EmployeesDemo = "mfbdemo"
}

struct BaseNetwork {

    // function that returns session and Request for Combine
    func getSessionEmployees(offSet : Int = GlobalParams().offSetGlobal, begin: Int = 0, filter : String = "") -> (URLSession,NSMutableURLRequest) {
        let session = URLSession.shared
        var urlCad = "\(GlobalParams().api)\(Paths.EmployeesDemo.rawValue)"
        urlCad += "?idapp=\(GlobalParams().idMeta4App)"
        urlCad += "&idclient=\(GlobalParams().idMeta4Client)"
        urlCad += "&offset=\(offSet)"
        urlCad += "&filter=\(filter)"
        urlCad += "&begin=\(begin)"
        let url = URL(string: urlCad)
        print("NetWork URL:" + urlCad)
               
        let request = NSMutableURLRequest(url: url!)
         // headers
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Global.sharedInstance.getCredenciales(), forHTTPHeaderField: "Authorization")
        
        return (session,request)
    }
}

// clase singleton del sistema

class Global {
    static let sharedInstance = Global()
    
    // Credenciales
    var credenciales : String?
    var login : Bool = false
    
    private init() { }
    
    
    // functions return credentials
    
    // encript to Meta4 Format
    func encodeCredentials(user:String, pass : String) -> String {
        let cred : String =  user + ":" + pass
        return cred.toBase64()
        
    }

    func setCredenciales(cred : String){
        self.credenciales = cred
    }
    func getCredenciales() -> String {
        
        if self.login {
            return self.credenciales!
        }
        else{
            return GlobalParams().adminCredential // devuelvo credencial admnistradora
        }
    }
    
}
