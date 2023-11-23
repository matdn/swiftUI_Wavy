import SwiftUI

struct SurfSpotTile: View {
    var surfSpot: SurfSpot
   
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
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
            Circle()
               .foregroundColor(colorForCondition(surfSpot.condition))
               .frame(width: 15, height: 15)
               .padding(15)
                
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .cornerRadius(10)
        .padding(10)
        .clipped()
        
    }
    private func colorForCondition(_ condition: SurfCondition) -> Color {
            switch condition {
            case .good:
                return .green
            case .medium:
                return .yellow
            case .poor:
                return .red
            }
        }
}
