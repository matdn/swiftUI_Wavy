import SwiftUI
import UIKit

enum SurfCondition {
    case good, medium, poor
}

struct WaveData: Codable {
    let current: WaveCurrent
}

struct WaveCurrent: Codable {
    let waveHeight: Double
    let wavePeriod: Double

    enum CodingKeys: String, CodingKey {
        case waveHeight = "wave_height"
        case wavePeriod = "wave_period"
    }
}

struct SurfSpot: Identifiable {
    var id = UUID()
    var name: String
    var imageUrl: String
    var comments: [String] = []
    var condition: SurfCondition
    var latitude: Double
    var longitude: Double
}

let steelGray = Color(white: 0.8)

struct ContentView: View {
    
    @State private var _isShowingCreateSpotView = false
    @State private var _surfSpots = [
        SurfSpot(name: "Pipeline", imageUrl: "https://andyoucreations.com/wp-content/uploads/2016/12/Banzai-pipeline.jpg", condition: .medium,latitude: 21.661, longitude: -158.065),
        SurfSpot(name: "Mavericks",imageUrl: "https://i.ytimg.com/vi/qL9WFvPVo8o/maxresdefault.jpg",condition: .poor,latitude: 21.661, longitude: -158.065),
        SurfSpot(name: "Jaws",imageUrl: "https://a.espncdn.com/photo/2016/0125/r47177_1600x1014xx.jpg",condition: .good,latitude: 21.661, longitude: -158.065)
    ]
    @State private var searchText = ""
    var body: some View {
            NavigationView {
                List {
                    TextField("Rechercher un spot", text: $searchText)
                           .padding(7)
                           .listRowSeparator(.hidden)
                           .background(Color(.systemGray6))
                           .cornerRadius(8)
                                          
                       Button(action:{
                           _isShowingCreateSpotView = true
                           }) {
                               
                               ZStack(alignment: .topLeading) {
                                   Text("Ajouter un Spot")
                                       .frame(maxWidth:.infinity ,minHeight: 70)
                                       .padding()
                                       .foregroundStyle(Color.white)
                                   Image(systemName: "plus")
                                       .font(.title)
                                       .foregroundColor(.white)
                                       .padding([.top, .leading])
                               }
                               .sheet(isPresented: $_isShowingCreateSpotView) {
                                   CreateSpotView(surfSpots: $_surfSpots)
                               }
                           .background(steelGray)
                           .cornerRadius(10)
                       }
                    ForEach(Array(_surfSpots.enumerated()), id: \.element.id) { index, spot in
                        NavigationLink(destination: SurfSpotDetailView(surfSpots: $_surfSpots, spotIndex: index)) {
                            SurfSpotTile(surfSpot: spot)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                deleteSpot(spot)
                            } label: {
                                Label("Supprimer", systemImage: "trash")
                            }
                        }
                    }
                    .onDelete(perform: deleteSpotAtIndexSet)
                }
                .listStyle(PlainListStyle()) 
                .navigationTitle("Wavy")
                .sheet(isPresented: $_isShowingCreateSpotView) {
                    CreateSpotView(surfSpots: $_surfSpots)
                }
            }
        }

        private func deleteSpot(_ spot: SurfSpot) {
            if let index = _surfSpots.firstIndex(where: { $0.id == spot.id }) {
                _surfSpots.remove(at: index)
            }
        }

        private func deleteSpotAtIndexSet(_ indexSet: IndexSet) {
            _surfSpots.remove(atOffsets: indexSet)
        }
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
    }



