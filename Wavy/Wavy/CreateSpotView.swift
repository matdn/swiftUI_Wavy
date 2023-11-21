import SwiftUI


struct CreateSpotView: View {
    @State private var spotName: String = ""
    @State private var spotComment: String = ""
    @State private var imageUrl: String = ""

    var body: some View {
        Form {
            Section(header: Text("New spot")) {
                TextField("Nom du Spot", text: $spotName)
                TextField("Commentaire", text: $spotComment)
                TextField("URL de l'image", text: $imageUrl)
            }
            Section{
                Button("Créer Spot") {
                    
                }
            }
            .navigationTitle("Nouveau Spot")
        }
    }
}
