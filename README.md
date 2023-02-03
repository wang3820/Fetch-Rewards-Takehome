# Fetch Rewards Takehome Assignmet for iOS Software Interns

## Objective
The objective of this project is to build a native iOS application that can
- Retrieve data from an url
- Sort items by listId then by name
- Filter items with names that are blank or null
- Display items grouped by listId

## Components
### NetworkController
The primary functions of the NetworkController are
- Retrive data using the url
- Decode retrived data to swift data structures
- Filter, sort, and place items
- Make items reachable by the ContentView

### ContentView
The primary functions of the ContentView are
- Display items that has been processed by NetworkController with SwiftUI structures like List, Text, and NavigationLink
- Control the NetworkController


## Design decisions
1. Decodable structures, Item, with fields matches those of the json data were created. Because the name field could be null in the json data, the name field of the Item could be nil. I decided to handle this situation by assigning empty string to the name field of Item if the json data has null for the name field, not making the name field of Item optional. This avoid type checking in filtering, sorting, and displaying.
2. When sorting the Items by names, I noticed that many names of Items are in form "Item " + some number. Therefore, I decided not to sort the names by built in string comparasion as with string comparasion, Item with name "Item 6" will be placed after "Item 191". I decided to sort first by string length, then by string comparasion, this way the names in form of "Item " + some number will be sorted by that number and names not in that form will be in the correct position. 
3. For display of the items, I decided to make a list of NavigationLinks named after and sorted by each unique listId that navigates to a list of items with that listId, sorted by names. This way the app looks a lot cleaner than a big list of items. 

## Results

## Demo

## Testing

## Area of Improvements
