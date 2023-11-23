import SwiftUI

struct SurfSpotDetailView: View {
       @Binding var surfSpots: [SurfSpot]
       let spotIndex: Int
       @State private var userComment: String = ""
       @State private var editingCommentIndex: Int? = nil
       @State private var isShowingEditView: Bool = false
        @State private var waveData: WaveCurrent?
    
    var body: some View {
        ScrollView {
            VStack {
                Text(surfSpots[spotIndex].name)
                    .font(.title)
                    .padding(.top)

                AsyncImage(url: URL(string: surfSpots[spotIndex].imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
                
                Text("Latitude: \(surfSpots[spotIndex].latitude)")
                Text("Longitude: \(surfSpots[spotIndex].longitude)")
                
                Picker("Condition", selection: $surfSpots[spotIndex].condition) {
                    Text("Good").tag(SurfCondition.good)
                    Text("Fair").tag(SurfCondition.medium)
                    Text("Poor").tag(SurfCondition.poor)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                
                // Champ de texte pour ajouter un commentaire
                TextField("Laissez un commentaire", text: $userComment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Bouton pour soumettre le commentaire
                Button("Soumettre") {
                    if !userComment.isEmpty {
                        surfSpots[spotIndex].comments.append(userComment)
                        userComment = ""
                    }
                }
                .padding()
                if let waveCurrent = waveData {
                    let roundedWaveHeight = (waveCurrent.waveHeight * 10).rounded() / 10
                    let roundedWavePeriod = (waveCurrent.wavePeriod * 10).rounded() / 10

                    Text("Hauteur des vagues: \(roundedWaveHeight, specifier: "%.1f") m")
                    Text("Période des vagues: \(roundedWavePeriod, specifier: "%.1f") s")
                } else {
                    Text("Chargement des données des vagues...")
                }
               
                ForEach(surfSpots[spotIndex].comments.indices, id: \.self) { index in
                    HStack {
                        Text(surfSpots[spotIndex].comments[index])
                            .padding()

                        Spacer()

                        Button(action: {
                            editingCommentIndex = index
                            userComment = surfSpots[spotIndex].comments[index]
                            isShowingEditView = true
                        }) {
                            Image(systemName: "pencil")
                            }
                        }
                    }
                }
            }
        .sheet(isPresented: $isShowingEditView) {
            VStack {
                TextField("Modifier le commentaire", text: $userComment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Sauvegarder") {
                    if let index = editingCommentIndex {
                        surfSpots[spotIndex].comments[index] = userComment
                        isShowingEditView = false
                    }
                }
                .padding()
            }
        } .onAppear(perform: fetchWaveData)
        .navigationTitle("Détails du Spot")
        .padding()
    }
    func fetchWaveData() {
        let selectedSpot = surfSpots[spotIndex]
        guard let url = URL(string: "https://marine-api.open-meteo.com/v1/marine?latitude=\(selectedSpot.latitude)&longitude=\(selectedSpot.longitude)&current=wave_height,wave_period&hourly=wave_height") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(WaveData.self, from: data) {
                    DispatchQueue.main.async {
                        self.waveData = decodedResponse.current
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}
