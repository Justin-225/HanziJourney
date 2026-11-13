import SwiftUI

// MARK: - Tab 1 首頁「今日一字」
struct HomeView: View {
    @State private var today = HanziCharacter.all.randomElement()!

    private let columns = [GridItem(.adaptive(minimum: 90), spacing: 12)]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                todayCard
                    .padding(.horizontal)

                featuredSection

                gridSection
                    .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("今日一字")
        .toolbar {
            Button("換一個", systemImage: "shuffle") {
                withAnimation(.smooth(duration: 0.6)) {
                    today = HanziCharacter.all.filter { $0 != today }.randomElement()!
                }
            }
        }
        .navigationDestination(for: HanziCharacter.self) { character in
            CharacterDetailView(character: character)
        }
    }

    // 今日一字大卡片
    private var todayCard: some View {
        NavigationLink(value: today) {
            HStack(spacing: 20) {
                GlyphView(character: today, stage: .oracle, color: .brown)
                    .frame(width: 100, height: 100)
                    .id(today.id)
                    .transition(.blurReplace)

                VStack(alignment: .leading, spacing: 6) {
                    Text("今日一字")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(today.character)  \(today.pinyin)")
                        .font(.largeTitle.bold())
                    Text(today.origin)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                Spacer(minLength: 0)
            }
            .cardStyle()
        }
        .buttonStyle(.plain)
    }

    // 水平捲動的精選區塊（上下捲動頁面裡的水平捲動）
    private var featuredSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("象形字精選")
                .font(.title2.bold())
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(HanziCharacter.all) { character in
                        NavigationLink(value: character) {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack(spacing: 14) {
                                    GlyphView(character: character, stage: .oracle, color: .brown)
                                        .frame(width: 64, height: 64)
                                    Image(systemName: "arrow.right")
                                        .foregroundStyle(.tertiary)
                                    Text(character.character)
                                        .font(.system(size: 48, weight: .bold))
                                }
                                Text(character.origin)
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                            }
                            .frame(width: 220, alignment: .leading)
                            .cardStyle()
                        }
                        .buttonStyle(.plain)
                        .scrollTransition { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1 : 0.85)
                                .opacity(phase.isIdentity ? 1 : 0.5)
                        }
                    }
                }
                .scrollTargetLayout()
                .padding(.vertical, 8)
            }
            .contentMargins(.horizontal, 16, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
        }
    }

    // 格子狀照片牆
    private var gridSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("全部的字")
                .font(.title2.bold())

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(HanziCharacter.all) { character in
                    NavigationLink(value: character) {
                        VStack(spacing: 6) {
                            Text(character.character)
                                .font(.system(size: 40, weight: .semibold))
                            Text(character.pinyin)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, minHeight: 90)
                        .cardStyle()
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environment(FavoriteStore())
}
