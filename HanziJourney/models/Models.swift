import SwiftUI

// MARK: - 字體階段（有圖片的三種 + 楷書用 Text 顯示）
enum ScriptStage: String, CaseIterable, Identifiable, Hashable {
    case oracle, bronze, seal, regular

    var id: String { rawValue }

    var name: String {
        switch self {
        case .oracle: "甲骨文"
        case .bronze: "金文"
        case .seal: "小篆"
        case .regular: "楷書"
        }
    }

    var period: String {
        switch self {
        case .oracle: "商"
        case .bronze: "商・周"
        case .seal: "秦"
        case .regular: "魏晉至今"
        }
    }

    var color: Color {
        switch self {
        case .oracle: .brown
        case .bronze: .teal
        case .seal: .indigo
        case .regular: .red
        }
    }
}

// MARK: - 一個漢字
struct HanziCharacter: Identifiable, Hashable {
    let id: String              // 圖片名稱前綴，例如 "ma"
    let character: String       // 馬
    let pinyin: String          // mǎ
    let meaning: String         // 一句話意思
    let origin: String          // 字源簡介
    let stageNotes: [ScriptStage: String]
    let words: [String]         // 相關詞語

    /// 楷書沒有圖片，回傳 nil
    func imageName(for stage: ScriptStage) -> String? {
        stage == .regular ? nil : "\(id)_\(stage.rawValue)"
    }
}

// MARK: - 造字法（六書）
struct MethodExample: Identifiable, Hashable {
    let id = UUID()
    let character: String       // 例字
    let formula: String         // 例如「日 + 月」
    let explanation: String
    let relatedIDs: [String]    // 對應到 10 個字裡的哪些（可點擊跳轉）
}

struct MakingMethod: Identifiable, Hashable {
    let id: String
    let name: String            // 象形
    let symbol: String          // SF Symbol
    let summary: String         // 一句話
    let detail: String
    let examples: [MethodExample]
}

// MARK: - 字體年表
struct ScriptEra: Identifiable, Hashable {
    let id: String
    let name: String
    let dynasty: String
    let years: String
    let tool: String            // 書寫材料與工具
    let toolSymbol: String
    let description: String
    let funFact: String
    let color: Color
    let stage: ScriptStage?     // 有對應圖片的時期才有值
}
