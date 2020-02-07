//
//  RowViewEmployee.swift
//  SwiftUIMeta4FullBackend
//
//  Created by Jose Luis on 05/02/2020.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import SwiftUI
import Combine

struct RowViewEmployee: View {
    let empleado : employee
    @ObservedObject var image = loadEmployeeImage()
    
    @State var isActive = false
    
    var body: some View {
        NavigationLink(destination: DetailEmployeeView(empleado: empleado, foto: image.image), isActive: self.$isActive, label: {
        
            VStack(alignment: .leading) {
                   HStack {
                       image.image
                           .resizable()
                           .modifier(ImageStyle())
                           
                        VStack {
                           Text("\(empleado.name)")
                               .modifier(HeaderTextStyle())
                           Text("\(empleado.start?.replacingOccurrences(of: "00:00:00", with: "") ?? "")")

                       }
                       .padding()
                   }
                   .onAppear{
                    if (self.empleado.idphoto != "" && self.empleado.idphoto != " "){
                           self.image.loadImage(idImage: self.empleado.idphoto!)
                    }
                   }
               }
        })
    }
    
    
}

struct RowViewEmployee_Previews: PreviewProvider {
    static var previews: some View {
        RowViewEmployee(empleado: loadDataEmployees().testData())
        //.previewDisplayName("Celda Lista Empleado")
   
        //.previewLayout(PreviewLayout.fixed(width: 480, height: 200))
    }
}





