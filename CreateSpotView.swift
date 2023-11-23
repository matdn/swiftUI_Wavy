import SwiftUI


struct CreateSpotView: View {
    @Binding var surfSpots: [SurfSpot]
        @State private var spotName: String = ""
        @State private var spotComment: String = ""
        @State private var imageUrl: String = ""
        @State private var selectedCondition: SurfCondition = .good
        @State private var latitude: String = ""
        @State private var longitude: String = ""
        @Environment(\.presentationMode) var presentationMode

    var body: some View {
            Form {
                Section(header: Text("New spot")) {
                        TextField("Nom du Spot", text: $spotName)
                        TextField("Commentaire", text: $spotComment)
                        TextField("URL de l'image", text: $imageUrl)
                        TextField("Latitude", text: $latitude)
                            .keyboardType(.decimalPad) // Utilisez un clavier adapté pour la saisie numérique
                        TextField("Longitude", text: $longitude)
                            .keyboardType(.decimalPad)
                }
                Section(header: Text("Condition de surf")) {
                    Picker("Condition", selection: $selectedCondition) {
                        Text("Good").tag(SurfCondition.good)
                        Text("Fair").tag(SurfCondition.medium)
                        Text("Poor").tag(SurfCondition.poor)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Button("Ajouter un Spot") {
                        if let lat = Double(latitude), let lon = Double(longitude) {
                            let newSpot = SurfSpot(name: spotName, imageUrl: imageUrl, condition: selectedCondition, latitude:lat, longitude: lon)
                            surfSpots.append(newSpot)
                            presentationMode.wrappedValue.dismiss()
                            
                        }
                    }
                }
                .navigationTitle("Nouveau Spot")
            }
           
        }
    private func addSpot() {
        if let lat = Double(latitude), let lon = Double(longitude) {
            let newSpot = SurfSpot(name: spotName, imageUrl: imageUrl, condition: selectedCondition, latitude: lat, longitude: lon)
            surfSpots.append(newSpot)
            presentationMode.wrappedValue.dismiss()
        } else {
        }
    }

}

