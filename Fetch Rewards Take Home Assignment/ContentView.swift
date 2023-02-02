//
//  ContentView.swift
//  Fetch Rewards Take Home Assignment
//
//  Created by Tong Wang on 2/1/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkController:NetworkController = NetworkController()
    var body: some View {
        NavigationView{
            ZStack{
                VStack {
                    Text("Items by ListId").fontWeight(.bold).font(.system(.title, design: .rounded))
                    List{
                        ForEach(Array(networkController.itemsByListid.keys.sorted(by: <).enumerated()), id: \.element){
                            _, key in
                            NavigationLink {
                                Text("listId " + String(key)).fontWeight(.bold).font(.system(.title, design: .rounded))
                                List(networkController.itemsByListid[key] ?? []) {item in
                                    Text(item.name)
                                }
                            } label: {
                                Text("listId " + String(key))
                            }

                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
