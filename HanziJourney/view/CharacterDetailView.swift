import SwiftUI

// MARK: - 字的詳細頁：演變動畫
struct CharacterDetailView: View {
    let character: HanziCharacter

    @Environment(FavoriteStore.self) private var favorites
    @State private var stage: ScriptStage = .oracle
    @State private var isPlaying = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                glyphStage
                stagePicker
                playButton
                noteCard
                infoCard
                wordsSection
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(character.character)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    favorites.toggle(character)
                } label: {
                    Image(systemName: favorites.isFavorite(character) ? "heart.fill" : "heart")
                        .foregroundStyle(.pink)
                        .symbolEffect(.bounce, value: favorites.isFavorite(character))
                }
            }
        }
        .sensoryFeedback(.selection, trigger: stage)
    }

    // 大字展示區：切換時模糊溶解
    private var glyphStage: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .fill(stage.color.opacity(0.12))

            GlyphView(character: character, stage: stage, color: stage.color)
                .padding(48)
                .id(stage)
                .transition(.blurReplace)
        }
        .frame(height: 300)
        .overlay(alignment: .topLeading) {
            Text("\(stage.name)・\(stage.period)")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(stage.color, in: .capsule)
                .padding()
        }
        .contentShape(.rect)
        // 左右滑動切換時期
        .gesture(
            DragGesture(minimumDistance: 30)
                .onEnded { value in
                    move(by: value.translation.width < 0 ? 1 : -1)
                }
        )
    }

    // 時間軸
    private var stagePicker: some View {
        HStack(spacing: 0) {
            ForEach(ScriptStage.allCases) { item in
                let isSelected = item == stage
                Button {
                    withAnimation(.smooth(duration: 0.6)) {
                        stage = item
                    }
                } label: {
                    VStack(spacing: 6) {
                        Circle()
                            .fill(isSelected ? item.color : Color.secondary.opacity(0.3))
                            .frame(width: isSelected ? 18 : 12, height: isSelected ? 18 : 12)
                            .frame(width: 18, height: 18)
                        Text(item.name)
                            .font(.caption.weight(isSelected ? .bold : .regular))
                            .foregroundStyle(isSelected ? item.color : .secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .background(alignment: .top) {
            Rectangle()
                .fill(Color.secondary.opacity(0.3))
                .frame(height: 2)
                .padding(.top, 8)
                .padding(.horizontal, 40)
        }
    }

    private var playButton: some View {
        Button(isPlaying ? "演變中…" : "自動播放演變", systemImage: "play.circle.fill") {
            Task { await playEvolution() }
        }
        .buttonStyle(.borderedProminent)
        .tint(stage.color)
        .disabled(isPlaying)
    }

    // 這個時期的說明
    private var noteCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(stage.name, systemImage: "sparkles")
                .font(.headline)
                .foregroundStyle(stage.color)
            Text(character.stageNotes[stage] ?? "")
                .id(stage)
                .transition(.opacity)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }

    // 加分項：組合多種文字樣式
    private var infoCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(Text(character.character).font(.title).bold().foregroundStyle(.red))  \(Text(character.pinyin).foregroundStyle(.secondary))")
            Text("字義：\(Text(character.meaning).bold())")
            Text("字源：\(Text(character.origin).foregroundStyle(.secondary))")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }

    private var wordsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("相關詞語")
                .font(.title3.bold())
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(character.words, id: \.self) { word in
                        Text(word)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Color(.secondarySystemGroupedBackground), in: .capsule)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - 動作
    private func move(by offset: Int) {
        let all = ScriptStage.allCases
        guard let index = all.firstIndex(of: stage) else { return }
        let next = index + offset
        guard all.indices.contains(next) else { return }
        withAnimation(.smooth(duration: 0.6)) {
            stage = all[next]
        }
    }

    private func playEvolution() async {
        isPlaying = true
        for item in ScriptStage.allCases {
            withAnimation(.smooth(duration: 0.8)) {
                stage = item
            }
            try? await Task.sleep(for: .seconds(1.3))
        }
        isPlaying = false
    }
}

#Preview {
    NavigationStack {
        CharacterDetailView(character: HanziCharacter.all[3])
    }
    .environment(FavoriteStore())
}
