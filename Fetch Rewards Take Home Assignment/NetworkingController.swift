//
//  NetworkingController.swift
//  Fetch Rewards Take Home Assignment
//
//  Created by Tong Wang on 2/1/23.
//

import Foundation
import SwiftUI

class NetworkController: NSObject, ObservableObject {
    @Published var itemsByListid = [Int:[Item]]()
    
    override public init () {
        super.init()
        retrieveData() {filteredByListid in
            self.itemsByListid = filteredByListid
        }
    }
     
    // This function retrieves data from the url and decode the json data to an array of item
    // Then it filters out items with empty string as names and sorted the array by listid and name
    // Finally it converts the array to a dictionary with listId as key and [Item] with all items
    // of that listId as value and pass the dictionary in the completetion callback
    func retrieveData(completion: @escaping (Dictionary<Int, [Item]>) -> Void) {
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
                
                completion(filteredByListid)
            }
            catch{
                print(error)
            }

        }.resume()
    }
}


// Auxiliary function to reducing nesting in sorting
func compareNames (name1: String, name2: String) -> Bool {
    if name1.count < name2.count {
        return true
    }
    else if name1.count == name2.count {
        return name1 < name2
    }
    
    return false
}
