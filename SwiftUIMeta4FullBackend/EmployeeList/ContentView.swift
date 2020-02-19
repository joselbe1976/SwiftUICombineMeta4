//
//  ContentView.swift
//  SwiftUIMeta4FullBackend
//
//  Created by Jose Luis on 03/02/2020.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var employees = loadDataEmployees()
    
    #if os(iOS) || os(tvOS)
    
    var body: some View {
        NavigationView{
                List{
                    ForEach(employees.m4dataEmployees, id:\.self) { empleado in
                        RowViewEmployee(empleado: empleado)
                        
                    }
                }
        .navigationBarTitle("Empleados Meta4")
        }
    }
    #else
    var body: some View {
              List{
                    ForEach(employees.m4dataEmployees, id:\.self) { empleado in
                        RowViewEmployee(empleado: empleado)
                        
                    }
              
                }.listStyle(CarouselListStyle())
    
    }
    #endif
}



struct ContentView_Previews: PreviewProvider {
     
    static var previews: some View {
        
        ContentView()
    }
}


