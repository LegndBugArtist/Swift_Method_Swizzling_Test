//
//  ContentView.swift
//  MethodSwizzling
//
//  Created by 刘喆 on 2022-03-04.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = TestModel()
    var body: some View {
        Button("按钮") {
            model.hello()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
