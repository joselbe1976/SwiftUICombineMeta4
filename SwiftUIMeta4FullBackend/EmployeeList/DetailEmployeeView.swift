//
//  DetailEmployeeView.swift
//  SwiftUIMeta4FullBackend
//
//  Created by Jose Luis on 05/02/2020.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import SwiftUI

struct DetailEmployeeView: View {
    let empleado : employee
    let foto : Image
    
    
    
    var body: some View {
        VStack{
            foto
                .resizable()
                .frame(width: 100, height: 100)
            Text("\(empleado.name)")
        }
    }
}

struct DetailEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEmployeeView(empleado: employee(idrh: "10010", name: "Jose Luis Bustos", idphoto: "zzz", start: "14/02/1976"), foto: Image(systemName: "person.fill"))
    }
}
