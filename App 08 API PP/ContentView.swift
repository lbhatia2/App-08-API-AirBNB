//
//  ContentView.swift
//  App 08 API PP
//
//  Created by Lina Bhatia on 7/26/22.
//

import SwiftUI

struct ContentView: View {
    @State private var airBNB = [AirBNB]()
    @State private var showingAlert = false
    var body: some View {
        NavigationView{
            List(airBNB){airBNBs in
                NavigationLink(destination: Text(airBNBs.image)
                    .padding()){
                        Text(airBNBs.title)
                    }
            }
            .navigationTitle("AirBNB")
        }
        .onAppear(perform: {
            AirBND()
        })
        .alert(isPresented: $showingAlert){
            Alert(title: Text("Loading erorr"),
                  message: Text("There was a problem loading the data"),
                  dismissButton: .default(Text("OK")))
        }

    }
    
    func AirBND() {
        let apiKey = "?rapidapi-key=d3536bf3fbmsh8949c2bb1c6d036p1a2ca1jsnad0c31252dbe"
        let query = "https://airbnb19.p.rapidapi.com/api/v1/getCategory\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                if json["status"] == true {
                    let contents = json["data"].arrayValue
                    for item in contents {
                        let aid = item["id"].stringValue
                        let title = item["title"].stringValue
                        let Image = item["image"].stringValue
                        let airBNBd = AirBNB(title: title, image: Image)
                        airBNB.append(airBNBd)
                    }
                    return
                    
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

struct AirBNB: Identifiable{
    let id = UUID()
    var aid = String()
    var title = String()
    var image = String()
}

