//
//  ContentView.swift
//  PlantIdentifier
//
//  Created by Christopher on 01/05/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTIES
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Flower.name, ascending: true)],
        animation: .default)
    private var flowers: FetchedResults<Flower>
    
    @State private var isShowingSettings: Bool = false
    @State private var showCaptureImageView: Bool = false
    @State private var image: UIImage? = nil

    // MARK: - BODY
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Spacer()
                    Button(action: {
                        self.showCaptureImageView.toggle()
                    }, label: {
                        HStack {
                            Text("Scan a flower")
                                .font(.callout)
                                .foregroundColor(.accentColor)
                            Image(systemName: "camera")
                                .foregroundColor(.accentColor)
                        }
                    })
                } //: HSTACK

                ForEach(flowers) { flower in
                    NavigationLink(
                        destination: FlowerDetailView(),
                        label: {
                            FlowerRowView(flower: flower)
                                .padding(.vertical, 4)
                        }
                    )
                } //: LOOP
            } //: LIST
            .navigationTitle("Flowers")
            .navigationBarItems(trailing: Button(action: {
            isShowingSettings = true}, label: {
                Image(systemName: "slider.horizontal.3")
            }))
            .sheet(isPresented: $isShowingSettings) {
                SettingsView()
            }
            .fullScreenCover(isPresented: self.$showCaptureImageView, content: {
                CaptureImageView(isShown: $showCaptureImageView, image: $image)
            })
        } //: NAVIGATION
    }

    private func addItem() {
        withAnimation {
            let newItem = Flower(context: viewContext)
            newItem.name = "Newly added name"
            newItem.desc = "This is a description for the item"
            newItem.image = image?.jpegData(compressionQuality: 1.0)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { flowers[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
