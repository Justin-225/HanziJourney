import SwiftUI

// MARK: - 卡片樣式（加分項：ViewModifier 簡化重複的 modifier）
struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16)
            .background(Color(.secondarySystemGroupedBackground), in: .rect(cornerRadius: 20))
            .shadow(color: .black.opacity(0.06), radius: 8, y: 4)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
}

// MARK: - 顯示某個字在某個時期的樣子
/// 甲骨文／金文／小篆用圖片，楷書直接用文字
struct GlyphView: View {
    let character: HanziCharacter
    let stage: ScriptStage
    var color: Color = .primary

    var body: some View {
        if let name = character.imageName(for: stage) {
            Image(name)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(color)
        } else {
            Text(character.character)
                .font(.system(size: 300, design: .serif))
                .minimumScaleFactor(0.05)
                .lineLimit(1)
                .foregroundStyle(color)
        }
    }
}

// MARK: - 答錯時的搖晃動畫
struct ShakeEffect: GeometryEffect {
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        let offset = 10 * sin(animatableData * .pi * 4)
        return ProjectionTransform(CGAffineTransform(translationX: offset, y: 0))
    }
}
