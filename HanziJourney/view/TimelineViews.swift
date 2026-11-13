import SwiftUI

// MARK: - Tab 3 字體年表
// 注意：SwiftUI 已經有內建的 TimelineView，所以這裡取名 ScriptTimelineView
struct ScriptTimelineView: View {
    private let ancient = Array(ScriptEra.all.prefix(3))
    private let modern = Array(ScriptEra.all.dropFirst(3))

    var body: some View {
        ScrollView {
            // 加分項：LazyVStack 搭配釘住的 section header
            LazyVStack(alignment: .leading, spacing: 12, pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(ancient) { era in
                        EraRow(era: era).padding(.horizontal)
                    }
                } header: {
                    sectionHeader(title: "古文字", subtitle: "還看得出圖畫的影子")
                }

                Section {
                    ForEach(modern) { era in
                        EraRow(era: era).padding(.horizontal)
                    }
                } header: {
                    sectionHeader(title: "今文字", subtitle: "隸變之後，變成一筆一畫")
                }
            }
            .padding(.bottom)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("字體年表")
        .navigationDestination(for: ScriptEra.self) { era in
            EraDetailView(era: era)
        }
        .navigationDestination(for: HanziCharacter.self) { character in
            CharacterDetailView(character: character)
        }
    }

    private func sectionHeader(title: String, subtitle: String) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.title2.bold())
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(.bar)
    }
}

// MARK: - 年表的一列（左側彩色線條）
struct EraRow: View {
    let era: ScriptEra

    var body: some View {
        NavigationLink(value: era) {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(era.name)
                        .font(.title3.bold())
                        .foregroundStyle(era.color)
                    Text(era.years)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(width: 120, alignment: .leading)

                VStack(alignment: .leading, spacing: 4) {
                    Label(era.dynasty, systemImage: "building.columns")
                        .font(.subheadline)
                    Label(era.tool, systemImage: era.toolSymbol)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Spacer(minLength: 0)

                Image(systemName: "chevron.right")
                    .foregroundStyle(.tertiary)
            }
            .padding(.leading, 10)
            .cardStyle()
            .overlay(alignment: .leading) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(era.color)
                    .frame(width: 4)
                    .padding(.vertical, 14)
                    .padding(.leading, 12)
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - 時期詳細頁
struct EraDetailView: View {
    let era: ScriptEra

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                hero

                HStack(spacing: 12) {
                    infoTile(title: "朝代", value: era.dynasty, symbol: "building.columns")
                    infoTile(title: "工具", value: era.tool, symbol: era.toolSymbol)
                }

                Text(era.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cardStyle()

                VStack(alignment: .leading, spacing: 8) {
                    Label("冷知識", systemImage: "lightbulb.fill")
                        .font(.headline)
                        .foregroundStyle(.orange)
                        .symbolEffect(.pulse)
                    Text(era.funFact)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .cardStyle()

                if let stage = era.stage {
                    gallery(stage: stage)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(era.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 6) {
            Spacer()
            Text(era.name)
                .font(.system(size: 48, weight: .black, design: .serif))
            Text(era.years)
                .font(.headline)
                .opacity(0.85)
        }
        .foregroundStyle(.white)
        .padding(24)
        .frame(maxWidth: .infinity, minHeight: 200, alignment: .leading)
        .background(
            LinearGradient(colors: [era.color, era.color.opacity(0.6)],
                           startPoint: .topLeading, endPoint: .bottomTrailing),
            in: .rect(cornerRadius: 28)
        )
    }

    private func infoTile(title: String, value: String, symbol: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: symbol)
                .font(.title2)
                .foregroundStyle(era.color)
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }

    // 水平滑動分頁：這個時期的 10 個字
    private func gallery(stage: ScriptStage) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("這個時期的字長這樣")
                .font(.title2.bold())

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(HanziCharacter.all) { character in
                        NavigationLink(value: character) {
                            VStack(spacing: 12) {
                                GlyphView(character: character, stage: stage, color: era.color)
                                    .frame(height: 160)
                                Text("\(character.character)・\(character.pinyin)")
                                    .font(.headline)
                                Text("左右滑動看下一個 →")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(24)
                            .frame(maxWidth: .infinity)
                            .background(era.color.opacity(0.1), in: .rect(cornerRadius: 24))
                            .padding(.horizontal, 4)
                        }
                        .buttonStyle(.plain)
                        .containerRelativeFrame(.horizontal)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
        }
    }
}

#Preview {
    NavigationStack {
        ScriptTimelineView()
    }
    .environment(FavoriteStore())
}
