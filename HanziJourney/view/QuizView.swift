import SwiftUI

struct QuizQuestion: Identifiable {
    let id = UUID()
    let answer: HanziCharacter
    let options: [HanziCharacter]
}

// MARK: - Tab 4 猜字遊戲
struct QuizView: View {
    @State private var level: ScriptStage = .oracle
    @State private var questions: [QuizQuestion] = []
    @State private var index = 0
    @State private var selected: HanziCharacter?
    @State private var score = 0
    @State private var wrongCount = 0      // 每答錯一次 +1，觸發搖晃
    @State private var finished = false

    private let levels: [ScriptStage] = [.oracle, .bronze, .seal]

    var body: some View {
        VStack {
            if finished {
                resultView
            } else if let question = current {
                questionView(question)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("猜字遊戲")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Picker("難度", selection: $level) {
                        ForEach(levels) { item in
                            Text(item.name).tag(item)
                        }
                    }
                } label: {
                    Label("難度", systemImage: "slider.horizontal.3")
                }
            }
        }
        .onAppear {
            if questions.isEmpty { restart() }
        }
        .onChange(of: level) {
            withAnimation { restart() }
        }
        .sensoryFeedback(.success, trigger: score)
        .sensoryFeedback(.error, trigger: wrongCount)
    }

    private var current: QuizQuestion? {
        questions.indices.contains(index) ? questions[index] : nil
    }

    // MARK: 題目畫面
    private func questionView(_ question: QuizQuestion) -> some View {
        VStack(spacing: 20) {
            HStack {
                Text("第 \(index + 1) / \(questions.count) 題")
                Spacer()
                Label("\(score)", systemImage: "star.fill")
                    .foregroundStyle(.orange)
                    .contentTransition(.numericText())
            }
            .font(.headline)

            ProgressView(value: Double(index), total: Double(questions.count))
                .tint(level.color)

            Text("這個\(level.name)是哪個字？")
                .font(.title3.bold())

            GlyphView(character: question.answer, stage: level, color: level.color)
                .frame(height: 180)
                .padding(24)
                .frame(maxWidth: .infinity)
                .background(Color(.secondarySystemGroupedBackground), in: .rect(cornerRadius: 28))
                .modifier(ShakeEffect(animatableData: CGFloat(wrongCount)))
                .id(question.id)
                .transition(.blurReplace)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(question.options) { option in
                    Button {
                        answer(option, for: question)
                    } label: {
                        Text(option.character)
                            .font(.system(size: 40, weight: .bold))
                            .frame(maxWidth: .infinity, minHeight: 80)
                            .background(optionColor(option, question), in: .rect(cornerRadius: 20))
                            .scaleEffect(selected != nil && option == question.answer ? 1.06 : 1)
                    }
                    .buttonStyle(.plain)
                    .disabled(selected != nil)
                }
            }

            if selected != nil {
                Button(index + 1 < questions.count ? "下一題" : "看結果") {
                    next()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(level.color)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }

            Spacer(minLength: 0)
        }
    }

    // MARK: 結果畫面
    private var resultView: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: score >= 8 ? "trophy.fill" : score >= 5 ? "hand.thumbsup.fill" : "book.fill")
                .font(.system(size: 80))
                .foregroundStyle(.orange)
                .symbolEffect(.breathe)
            Text("\(score) / \(questions.count)")
                .font(.system(size: 56, weight: .bold, design: .rounded))
            Text(comment)
                .foregroundStyle(.secondary)
            Button("再玩一次", systemImage: "arrow.counterclockwise") {
                withAnimation { restart() }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(level.color)
            Spacer()
        }
        .transition(.scale.combined(with: .opacity))
    }

    private var comment: String {
        switch score {
        case 10: "全對！你根本是商朝人吧？"
        case 7...9: "很厲害，古文字難不倒你！"
        case 4...6: "還不錯，多看幾次演變就會更熟。"
        default: "沒關係，去「今日一字」複習一下再來！"
        }
    }

    // MARK: 動作
    private func answer(_ option: HanziCharacter, for question: QuizQuestion) {
        withAnimation(.spring) { selected = option }
        if option == question.answer {
            withAnimation { score += 1 }
        } else {
            withAnimation(.linear(duration: 0.4)) { wrongCount += 1 }
        }
    }

    private func optionColor(_ option: HanziCharacter, _ question: QuizQuestion) -> Color {
        guard let selected else { return Color(.secondarySystemGroupedBackground) }
        if option == question.answer { return .green.opacity(0.3) }
        if option == selected { return .red.opacity(0.3) }
        return Color(.secondarySystemGroupedBackground)
    }

    private func next() {
        withAnimation(.smooth) {
            selected = nil
            if index + 1 < questions.count {
                index += 1
            } else {
                finished = true
            }
        }
    }

    private func restart() {
        questions = HanziCharacter.all.shuffled().map { answer in
            let others = HanziCharacter.all.filter { $0 != answer }.shuffled().prefix(3)
            return QuizQuestion(answer: answer, options: ([answer] + others).shuffled())
        }
        index = 0
        score = 0
        selected = nil
        finished = false
    }
}

#Preview {
    NavigationStack {
        QuizView()
    }
}
