//
//  Modifier.swift
//  SwiftUIMeta4FullBackend
//
//  Created by Jose Luis on 05/02/2020.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import SwiftUI

struct ImageStyle:ViewModifier {
    #if os(iOS) || os(tvOS)
        private var width : CGFloat = 100
        private var height : CGFloat = 100
    #else
        private var width : CGFloat = 50
        private var height : CGFloat = 50
    #endif
    
    func body(content: Content) -> some View {
            content
                .frame(width: width , height: height)
                .clipShape(Circle())
        
    }
}




struct HeaderTextStyle:ViewModifier {
    #if os(iOS) || os(tvOS)
        func body(content: Content) -> some View {
                   content
                       .font(.largeTitle)
                       .foregroundColor(Color.blue)
            
           }
    #else
       func body(content: Content) -> some View {
                  content
                    .foregroundColor(Color.yellow)
                      
          }
    #endif
}

struct SubTitleTextStyle:ViewModifier {
    #if os(iOS) || os(tvOS)
        func body(content: Content) -> some View {
                   content
            
           }
    #else
       func body(content: Content) -> some View {
                  content
                    .font(.footnote)
                    .foregroundColor(Color.yellow)
                      
          }
    #endif
}


