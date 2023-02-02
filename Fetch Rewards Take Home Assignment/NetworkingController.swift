//
//  NetworkingController.swift
//  Fetch Rewards Take Home Assignment
//
//  Created by Ray on 2/1/23.
//

import Foundation
import SwiftUI

class NetworkController: NSObject, ObservableObject {
    @Published var items = [Item]()
    @Published var itemsByListid = [Int:[Item]]()
    
    override public init () {
        super.init()
        retrieveData()
    }
    
    func retrieveData() {
        let urlRequest = URL(string: "https://fetch-hiring.s3.amazonaws.com/hiring.json")
        guard urlRequest != nil else {
            // This url should be valid
            return
        }
        
        let mySession = URLSession.shared
        
        mySession.dataTask(with: urlRequest!) { data, URLResponse, error in
            guard error == nil, let data = data else {
                print(error!.localizedDescription)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let tempItems = try decoder.self.decode([Item].self, from: data)
                
                var filtered = tempItems.filter({$0.name != ""})
                filtered.sort{item1, item2 in
                    if item1.listId < item2.listId {
                        return true
                    }
                    else if item1.listId == item2.listId {
                        return compareNames(name1: item1.name, name2: item2.name)
                    }
                    
                    return false
                }
                
                let filteredByListid = Dictionary(grouping: filtered, by: {$0.listId})
                
                DispatchQueue.main.async {
                    self.items = filtered
                    self.itemsByListid = filteredByListid
                }
            }
            catch{
                print(error)
            }

        }.resume()
        
        
    }
}

func compareNames (name1: String, name2: String) -> Bool {
    if name1.count < name2.count {
        return true
    }
    else if name1.count == name2.count {
        return name1 < name2
    }
    
    return false
}
