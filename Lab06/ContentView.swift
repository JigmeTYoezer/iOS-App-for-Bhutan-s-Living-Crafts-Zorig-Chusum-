import SwiftUI

struct Craft: Identifiable {
    let id = UUID()
    let name: String
    let englishName: String
    let imageName: String
    let description: String
}

let crafts: [Craft] = [
    Craft(
        name: "Shingzo",
        englishName: "Carpentry",
        imageName: "hammer.fill",
        description: "Shingzo is the traditional Bhutanese art of carpentry. Skilled craftsmen shape and join timber to create buildings, furniture, and decorative architectural elements."
    ),
    Craft(
        name: "Dozo",
        englishName: "Masonry",
        imageName: "building.2.fill",
        description: "Dozo is the traditional art of masonry, involving the careful construction of walls, buildings, and other structures using stone and other local materials."
    ),
    Craft(
        name: "Parzo",
        englishName: "Carving",
        imageName: "square.3.layers.3d",
        description: "Parzo is the art of carving intricate designs into wood, stone, and other materials. It is widely used to decorate Bhutanese architecture and traditional objects."
    ),
    Craft(
        name: "Lhazo",
        englishName: "Painting",
        imageName: "paintbrush.pointed.fill",
        description: "Lhazo is the traditional art of painting. Bhutanese artists create detailed religious, cultural, and decorative paintings, often using established traditional styles."
    ),
    Craft(
        name: "Jinzo",
        englishName: "Sculpting",
        imageName: "figure.stand",
        description: "Jinzo is the traditional craft of sculpting. Craftspeople create religious figures, statues, and decorative forms using materials such as clay, wood, and other substances."
    ),
    Craft(
        name: "Lugzo",
        englishName: "Bronze-casting",
        imageName: "flame.fill",
        description: "Lugzo is the craft of casting bronze and other metals into useful and artistic objects, including traditional religious and decorative items."
    ),
    Craft(
        name: "Garzo",
        englishName: "Blacksmithing",
        imageName: "wrench.and.screwdriver.fill",
        description: "Garzo is traditional blacksmithing, in which metal is heated, shaped, and finished to produce tools, household items, weapons, and other useful objects."
    ),
    Craft(
        name: "Troeko",
        englishName: "Ornament-making",
        imageName: "sparkles",
        description: "Troeko is the traditional making of ornaments and jewellery. Artisans create decorative pieces that reflect Bhutanese culture and traditional designs."
    ),
    Craft(
        name: "Tsharzo",
        englishName: "Cane and bamboo work",
        imageName: "leaf.fill",
        description: "Tsharzo involves preparing and weaving cane and bamboo into baskets, containers, mats, and other useful traditional products."
    ),
    Craft(
        name: "Thagzo",
        englishName: "Weaving",
        imageName: "rectangle.grid.2x2.fill",
        description: "Thagzo is Bhutan's traditional weaving craft. Weavers produce richly patterned textiles using traditional techniques and designs passed down through generations."
    ),
    Craft(
        name: "Tshemzo",
        englishName: "Tailoring, embroidery & appliqué",
        imageName: "scissors",
        description: "Tshemzo includes tailoring, embroidery, and appliqué. Artisans make and decorate traditional garments and textiles with careful stitching and colourful patterns."
    ),
    Craft(
        name: "Shagzo",
        englishName: "Woodturning",
        imageName: "circle.fill",
        description: "Shagzo is the traditional art of woodturning. Craftspeople shape pieces of wood into bowls, cups, containers, and other objects using turning techniques."
    ),
    Craft(
        name: "Deh-sho",
        englishName: "Paper-making",
        imageName: "doc.plaintext.fill",
        description: "Deh-sho is the traditional Bhutanese craft of making paper by hand from natural fibres. The finished paper is used for writing, printing, religious texts, and artwork."
    )
]

struct ContentView: View {
    @State private var searchText = ""
    @State private var visitedCrafts: Set<UUID> = []

    private var filteredCrafts: [Craft] {
        if searchText.isEmpty {
            return crafts
        }

        return crafts.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.englishName.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredCrafts) { craft in
                    NavigationLink {
                        CraftDetailView(
                            craft: craft,
                            isVisited: visitedCrafts.contains(craft.id)
                        ) {
                            if visitedCrafts.contains(craft.id) {
                                visitedCrafts.remove(craft.id)
                            } else {
                                visitedCrafts.insert(craft.id)
                            }
                        }
                    } label: {
                        HStack(spacing: 14) {
                            Image(systemName: craft.imageName)
                                .font(.title2)
                                .foregroundStyle(.orange)
                                .frame(width: 42, height: 42)
                                .background(.orange.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                            VStack(alignment: .leading, spacing: 4) {
                                Text(craft.name)
                                    .font(.headline)

                                Text(craft.englishName)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            if visitedCrafts.contains(craft.id) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .navigationTitle("Zorig Chusum")
            .searchable(text: $searchText, prompt: "Search crafts")
        }
    }
}

struct CraftDetailView: View {
    let craft: Craft
    let isVisited: Bool
    let toggleVisited: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(systemName: craft.imageName)
                    .font(.system(size: 90))
                    .foregroundStyle(.orange)
                    .frame(maxWidth: .infinity)
                    .frame(height: 190)
                    .background(.orange.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(.horizontal)

                VStack(spacing: 6) {
                    Text(craft.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(craft.englishName)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                Divider()
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    Text("About this craft")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(craft.description)
                        .font(.body)
                        .lineSpacing(5)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

                HStack {
                    Image(systemName: "checkmark.circle")
                    Text("Visited")
                    Spacer()
                    Toggle("", isOn: Binding(
                        get: { isVisited },
                        set: { _ in toggleVisited() }
                    ))
                    .labelsHidden()
                }
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle(craft.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
