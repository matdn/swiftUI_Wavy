//
//  ContentView.swift
//  Wavy
//
//  Created by Matis Dene on 20/11/2023.
//

import SwiftUI
import UIKit

struct SurfSpot: Identifiable {
    var id = UUID()
    var name: String
    var imageUrl: String
}

// Exemple de données
let surfSpots = [
    SurfSpot(name: "Pipeline", imageUrl: "https://andyoucreations.com/wp-content/uploads/2016/12/Banzai-pipeline.jpg"),
    SurfSpot(name: "Mavericks",imageUrl: "https://andyoucreations.com/wp-content/uploads/2016/12/Banzai-pipeline.jpg"),
    SurfSpot(name: "Jaws",imageUrl: "https://andyoucreations.com/wp-content/uploads/2016/12/Banzai-pipeline.jpg")
]

let steelGray = Color(white: 0.8)

struct ContentView: View {
    @State private var _isShowingCreateSpotView = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button(action:{
                        _isShowingCreateSpotView = true
                        }) {
                            
                            ZStack(alignment: .topLeading) {
                                Text("Ajouter un Spot")
                                    .frame(maxWidth:.infinity ,minHeight: 100)
                                    .padding()
                                    .foregroundStyle(Color.white)
                                Image(systemName: "plus")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding([.top, .leading])
                            }
                            .sheet(isPresented: $_isShowingCreateSpotView) {
                                                    CreateSpotView()
                                                }
                            .background(steelGray)
                            .cornerRadius(10)
                        }
                    ForEach(surfSpots) { spot in
                        SurfSpotTile(surfSpot: spot)
                    }
                }
            }
            .navigationTitle("Wavy")
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
