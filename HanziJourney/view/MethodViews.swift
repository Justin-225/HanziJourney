import SwiftUI

// MARK: - Tab 2 造字法列表
struct MethodListView: View {
    var body: some View {
        List {
            Section {
                Text("古人用六種方法造字，稱為「六書」。點進去看看每種方法的例子吧！")
                    .foregroundStyle(.secondary)
            }

            Section("六書") {
                ForEach(MakingMethod.all) { method in
                    NavigationLink(value: method) {
                        HStack(spacing: 14) {
                            Image(systemName: method.symbol)
                                .font(.title2)
                                .foregroundStyle(Color.accentColor)
                                .frame(width: 44, height: 44)
                                .background(Color.accentColor.opacity(0.12), in: .rect(cornerRadius: 12))
                            VStack(alignment: .leading, spacing: 2) {
                                Text(method.name)
                                    .font(.headline)
                                Text(method.summary)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("造字法")
        .navigationDestination(for: MakingMethod.self) { method in
            MethodDetailView(method: method)
        }
        .navigationDestination(for: HanziCharacter.self) { character in
            CharacterDetailView(character: character)
        }
    }
}

// MARK: - 造字法詳細頁
struct MethodDetailView: View {
    let method: MakingMethod
    @State private var appeared = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 16) {
                    Image(systemName: method.symbol)
                        .font(.system(size: 44))
                        .foregroundStyle(Color.accentColor)
                        .symbolEffect(.bounce, value: appeared)
                    Text(method.summary)
                        .font(.title3.bold())
                }

                Text(method.detail)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cardStyle()

                Text("例字")
                    .font(.title2.bold())

                ForEach(method.examples) { example in
                    exampleCard(example)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(method.name)
        .onAppear { appeared.toggle() }
    }

    private func exampleCard(_ example: MethodExample) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Text(example.character)
                    .font(.system(size: 44, weight: .bold))
                Text(example.formula)
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
            Text(example.explanation)

            // 可以點擊跳到字的詳細頁
            if !example.relatedIDs.isEmpty {
                HStack {
                    Text("看看演變：")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    ForEach(example.relatedIDs, id: \.self) { id in
                        if let character = HanziCharacter.find(id) {
                            NavigationLink(value: character) {
                                Text(character.character)
                                    .font(.headline)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.accentColor.opacity(0.15), in: .capsule)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}

#Preview {
    NavigationStack {
        MethodListView()
    }
    .environment(FavoriteStore())
}
