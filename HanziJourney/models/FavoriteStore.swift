import SwiftUI

/// 收藏的字，整個 App 共用（首頁加入、Tab 5 顯示）
@Observable
final class FavoriteStore {
    var ids: Set<String> = []

    func isFavorite(_ character: HanziCharacter) -> Bool {
        ids.contains(character.id)
    }

    func toggle(_ character: HanziCharacter) {
        if ids.contains(character.id) {
            ids.remove(character.id)
        } else {
            ids.insert(character.id)
        }
    }

    var characters: [HanziCharacter] {
        HanziCharacter.all.filter { ids.contains($0.id) }
    }
}
