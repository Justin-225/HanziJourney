import SwiftUI
import AVKit
import WebKit

// MARK: - Tab 5 更多
struct MoreView: View {
    @Environment(FavoriteStore.self) private var favorites

    var body: some View {
        List {
            Section("學習") {
                NavigationLink {
                    FavoritesView()
                } label: {
                    Label {
                        HStack {
                            Text("我的收藏")
                            Spacer()
                            Text("\(favorites.ids.count)")
                                .foregroundStyle(.secondary)
                        }
                    } icon: {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.pink)
                    }
                }

                NavigationLink {
                    WritingVideoView()
                } label: {
                    Label("書寫影片", systemImage: "play.rectangle.fill")
                }
            }

            Section("查詢") {
                NavigationLink {
                    DictionaryWebView()
                } label: {
                    Label("教育部異體字字典", systemImage: "globe")
                }
            }

            Section {
                NavigationLink {
                    AboutView()
                } label: {
                    Label("關於本 App", systemImage: "info.circle")
                }
            }
        }
        .navigationTitle("更多")
        .navigationDestination(for: HanziCharacter.self) { character in
            CharacterDetailView(character: character)
        }
    }
}

// MARK: - 我的收藏
struct FavoritesView: View {
    @Environment(FavoriteStore.self) private var favorites

    var body: some View {
        Group {
            if favorites.characters.isEmpty {
                ContentUnavailableView(
                    "還沒有收藏",
                    systemImage: "heart",
                    description: Text("在字的頁面點右上角的愛心，就能收藏到這裡。")
                )
            } else {
                List {
                    ForEach(favorites.characters) { character in
                        NavigationLink(value: character) {
                            HStack(spacing: 16) {
                                GlyphView(character: character, stage: .oracle, color: .brown)
                                    .frame(width: 44, height: 44)
                                Text(character.character)
                                    .font(.title.bold())
                                Text(character.meaning)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .swipeActions {
                            Button("移除", systemImage: "heart.slash", role: .destructive) {
                                withAnimation { favorites.toggle(character) }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("我的收藏")
    }
}

// MARK: - 書寫影片（VideoPlayer）
struct WritingVideoView: View {
    @State private var player = WritingVideoView.loadPlayer()

    var body: some View {
        Group {
            if let player {
                VideoPlayer(player: player)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding()
                    .onAppear { player.play() }
                    .onDisappear { player.pause() }
            } else {
                ContentUnavailableView(
                    "還沒有影片",
                    systemImage: "video.slash",
                    description: Text("把影片命名為 writing.mov 或 writing.mp4，拖進專案就會出現在這裡。")
                )
            }
        }
        .navigationTitle("書寫影片")
    }

    private static func loadPlayer() -> AVPlayer? {
        for ext in ["mov", "mp4"] {
            if let url = Bundle.main.url(forResource: "writing", withExtension: ext) {
                return AVPlayer(url: url)
            }
        }
        return nil
    }
}

// MARK: - 異體字字典（iOS 26 原生 WebView）
struct DictionaryWebView: View {
    var body: some View {
        WebView(url: URL(string: "https://dict.variants.moe.edu.tw/"))
            .navigationTitle("異體字字典")
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - 關於
struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("字")
                    .font(.system(size: 80, weight: .black, design: .serif))
                    .foregroundStyle(.white)
                    .frame(width: 140, height: 140)
                    .background(
                        LinearGradient(colors: [.brown, .red], startPoint: .topLeading, endPoint: .bottomTrailing),
                        in: .rect(cornerRadius: 32)
                    )

                Text("漢字的旅程")
                    .font(.title.bold())

                Text("從龜甲上的刻痕到手機裡的字型，一個字走了三千多年。這個 App 帶你看 10 個象形字如何一步步變成今天的樣子。")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)

                VStack(alignment: .leading, spacing: 10) {
                    Label("圖片來源", systemImage: "photo")
                        .font(.headline)
                    Text("古文字圖片來自 Wikimedia Commons 的 Ancient Chinese characters project（公有領域）。")
                    Link("前往 Wikimedia Commons",
                         destination: URL(string: "https://commons.wikimedia.org/wiki/Commons:Ancient_Chinese_characters_project")!)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .cardStyle()
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("關於")
    }
}

#Preview {
    NavigationStack {
        MoreView()
    }
    .environment(FavoriteStore())
}
