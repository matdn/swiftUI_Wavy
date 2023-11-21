import SwiftUI

struct SurfSpotTile: View {
    var surfSpot: SurfSpot

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: surfSpot.imageUrl)) { image in
                image.resizable()
                } placeholder: {
                    Rectangle().foregroundColor(.gray)
                }
                .aspectRatio(contentMode: .fill)
            HStack{
                Text(surfSpot.name)
                    .padding()
                    .foregroundColor(.white)
                Spacer()
            }
                
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .cornerRadius(10)
        .clipped()
    }
}
