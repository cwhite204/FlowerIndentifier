//
//  FlowerRowView.swift
//  PlantIdentifier
//
//  Created by Christopher on 01/05/2021.
//

import SwiftUI

struct FlowerRowView: View {
    var flower: Flower
    
    var body: some View {
        HStack {
            Image("")
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .shadow(color: Color(red: 0, green:0, blue: 0, opacity: 0.3), radius: 3, x: 2, y: 2)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 5) {
                Text("Rose")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("This is a type of plant that is definitiely a plant that people have seen.")
                    .font(.caption)
                    .foregroundColor(Color.secondary)
            }
        } //: HSTACK
    }
}

struct FlowerRowView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerRowView(flower: PersistenceController.previewFlower)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
