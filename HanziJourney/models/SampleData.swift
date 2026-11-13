import SwiftUI

// MARK: - 10 個字
extension HanziCharacter {
    static let all: [HanziCharacter] = [
        HanziCharacter(
            id: "ri", character: "日", pinyin: "rì",
            meaning: "太陽；白天；一天",
            origin: "畫一個太陽，中間的點代表太陽的光芒，也讓它和普通的圓圈有所區別。",
            stageNotes: [
                .oracle: "用刀在龜甲上刻圓形很難，所以常刻成方方的，中間有一點或一短橫。",
                .bronze: "鑄在青銅器上，終於能做出圓潤的圓形，中間的點更明顯。",
                .seal: "線條粗細一致，圓形拉長成橢圓，中間的點變成一橫。",
                .regular: "圓形變成方框，就是今天的「日」。"
            ],
            words: ["日出", "生日", "日記", "今日"]
        ),
        HanziCharacter(
            id: "yue", character: "月", pinyin: "yuè",
            meaning: "月亮；一個月",
            origin: "月亮大多時候不是圓的，所以古人畫的是一彎缺月，用來和「日」區分。",
            stageNotes: [
                .oracle: "一彎新月，裡面常加一短筆。甲骨文裡「月」和「夕」常常混用。",
                .bronze: "彎月更飽滿，筆畫也更粗。",
                .seal: "月形拉長，內部變成兩筆。",
                .regular: "彎月拉直成框。冷知識：「肚、腳」的月字旁其實是「肉」變來的，和月亮無關。"
            ],
            words: ["月亮", "月餅", "滿月", "歲月"]
        ),
        HanziCharacter(
            id: "ren", character: "人", pinyin: "rén",
            meaning: "人類；別人",
            origin: "畫一個側面站立的人，微微彎腰、手臂下垂。",
            stageNotes: [
                .oracle: "側面的人形，看得出頭、手臂和腿。",
                .bronze: "輪廓相似，筆畫較粗。",
                .seal: "線條變得對稱優美，像人彎著腰。",
                .regular: "只剩一撇一捺，像人的兩條腿。"
            ],
            words: ["人生", "大人", "主人", "人氣"]
        ),
        HanziCharacter(
            id: "ma", character: "馬", pinyin: "mǎ",
            meaning: "馬這種動物",
            origin: "畫一匹側面的馬，有大眼睛、鬃毛、腿和尾巴。",
            stageNotes: [
                .oracle: "馬是「直立」的！古人直行書寫，動物字常被轉成直的才排得下。",
                .bronze: "鬃毛更醒目，身體更寫意。",
                .seal: "線條化，但仍看得出鬃毛和腿。",
                .regular: "下面的四點「灬」不是火，是馬的腿和尾巴變來的。"
            ],
            words: ["馬上", "斑馬", "馬路", "馬虎"]
        ),
        HanziCharacter(
            id: "yu", character: "魚", pinyin: "yú",
            meaning: "魚",
            origin: "畫一條魚：魚頭、有鱗片的身體和分叉的魚尾。",
            stageNotes: [
                .oracle: "魚頭朝上直立擺放，鱗片和尾鰭都畫得很清楚。",
                .bronze: "鱗片變成格紋，魚鰭更明顯。",
                .seal: "魚頭變成尖角，身體變成像「田」的格子。",
                .regular: "下面四點同樣不是火，是魚尾變的。"
            ],
            words: ["金魚", "魚缸", "鯊魚", "如魚得水"]
        ),
        HanziCharacter(
            id: "niao", character: "鳥", pinyin: "niǎo",
            meaning: "鳥類",
            origin: "畫一隻側面的鳥，有尖嘴、翅膀和爪子。",
            stageNotes: [
                .oracle: "側面的鳥，嘴、眼、翅、爪一應俱全。",
                .bronze: "羽毛裝飾變多，有的像在展翅。",
                .seal: "頭、身、羽、爪仍能一一對應。",
                .regular: "下面四點由爪子和尾羽變來。"
            ],
            words: ["小鳥", "鳥巢", "候鳥", "一石二鳥"]
        ),
        HanziCharacter(
            id: "shan", character: "山", pinyin: "shān",
            meaning: "山",
            origin: "畫三座並排的山峰，用三個代表很多。",
            stageNotes: [
                .oracle: "三座尖尖的山峰並排。",
                .bronze: "有時整座山塗成實心，像剪影。",
                .seal: "線條化，中間的山峰最高。",
                .regular: "三座山峰變成三豎，中間仍然最高。"
            ],
            words: ["高山", "山頂", "火山", "人山人海"]
        ),
        HanziCharacter(
            id: "shui", character: "水", pinyin: "shuǐ",
            meaning: "水；河流",
            origin: "中間彎曲的線是水流，兩旁的點是濺起的水花。",
            stageNotes: [
                .oracle: "一道彎彎的水流，兩邊有點點水滴。",
                .bronze: "水流拉長，像一條河。",
                .seal: "中間一條曲線，兩旁各兩筆。",
                .regular: "當偏旁時寫成「氵」，三點正是水滴。"
            ],
            words: ["喝水", "水果", "口水", "山水"]
        ),
        HanziCharacter(
            id: "nv", character: "女", pinyin: "nǚ",
            meaning: "女性",
            origin: "畫一個跪坐的人，雙手交叉放在胸前。",
            stageNotes: [
                .oracle: "跪坐的人形，雙手在胸前交疊。",
                .bronze: "跪姿更明顯，有時頭上加了髮飾。",
                .seal: "線條化，交叉的手臂變成曲線。",
                .regular: "跪著的身體和交叉的手，變成今天的「女」。"
            ],
            words: ["女生", "女兒", "美女", "女王"]
        ),
        HanziCharacter(
            id: "che", character: "車", pinyin: "chē",
            meaning: "車子",
            origin: "從上往下看的一輛馬車：輪子、車軸和車廂。",
            stageNotes: [
                .oracle: "俯視的馬車，畫出兩個輪子、車軸和車廂，有時還有拉車的車轅。",
                .bronze: "結構最完整，有的連馬軛都畫出來。",
                .seal: "簡化了：上下兩橫是輪子，中間方框是車廂，一豎是車軸。",
                .regular: "沿用小篆的結構，就是今天的「車」。"
            ],
            words: ["火車", "車站", "腳踏車", "車水馬龍"]
        )
    ]

    static func find(_ id: String) -> HanziCharacter? {
        all.first { $0.id == id }
    }
}

// MARK: - 六書
extension MakingMethod {
    static let all: [MakingMethod] = [
        MakingMethod(
            id: "pictograph", name: "象形", symbol: "photo.artframe",
            summary: "照著東西的樣子畫出來",
            detail: "最早、最直覺的造字法。看到太陽就畫圓，看到山就畫山峰。這個 App 裡的 10 個字全都是象形字。",
            examples: [
                MethodExample(character: "日", formula: "畫太陽", explanation: "圓形加中間一點。", relatedIDs: ["ri"]),
                MethodExample(character: "馬", formula: "畫一匹馬", explanation: "眼睛、鬃毛、腿和尾巴。", relatedIDs: ["ma"]),
                MethodExample(character: "山", formula: "畫山峰", explanation: "三座山峰並排。", relatedIDs: ["shan"])
            ]
        ),
        MakingMethod(
            id: "indicative", name: "指事", symbol: "hand.point.up.left",
            summary: "用符號標出抽象的意思",
            detail: "有些概念畫不出來，例如「上、下」。古人就在圖形上加個記號，指出重點在哪。",
            examples: [
                MethodExample(character: "上", formula: "一橫 + 上方記號", explanation: "記號在橫線上面，表示上方。", relatedIDs: []),
                MethodExample(character: "本", formula: "木 + 下方一橫", explanation: "標出樹的根部，本義是樹根。", relatedIDs: []),
                MethodExample(character: "刃", formula: "刀 + 一點", explanation: "點出刀最鋒利的地方。", relatedIDs: [])
            ]
        ),
        MakingMethod(
            id: "compound", name: "會意", symbol: "plus.circle",
            summary: "把兩個字的意思合起來",
            detail: "組合兩個以上的字，讓意思疊加出新的意思。",
            examples: [
                MethodExample(character: "明", formula: "日 + 月", explanation: "太陽加月亮，當然很明亮。", relatedIDs: ["ri", "yue"]),
                MethodExample(character: "休", formula: "人 + 木", explanation: "人靠在樹旁，就是休息。", relatedIDs: ["ren"]),
                MethodExample(character: "好", formula: "女 + 子", explanation: "女子與孩子在一起，表示美好。", relatedIDs: ["nv"])
            ]
        ),
        MakingMethod(
            id: "phonetic", name: "形聲", symbol: "speaker.wave.2",
            summary: "一半表意思、一半表讀音",
            detail: "最有效率的造字法，現在八成以上的漢字都是形聲字。形旁告訴你類別，聲旁提示讀音。",
            examples: [
                MethodExample(character: "媽", formula: "女（意思）+ 馬（讀音）", explanation: "媽媽是女性，讀音像「馬」。", relatedIDs: ["nv", "ma"]),
                MethodExample(character: "河", formula: "水（意思）+ 可（讀音）", explanation: "和水有關，讀音來自「可」。", relatedIDs: ["shui"]),
                MethodExample(character: "鯨", formula: "魚（意思）+ 京（讀音）", explanation: "古人以為鯨魚是魚。", relatedIDs: ["yu"])
            ]
        ),
        MakingMethod(
            id: "derivative", name: "轉注", symbol: "arrow.left.arrow.right",
            summary: "意思相同、可以互相解釋的字",
            detail: "兩個字部首相同、意思相通，可以互相解釋。學者對它的定義至今仍有爭論。",
            examples: [
                MethodExample(character: "考・老", formula: "老 ↔ 考", explanation: "《說文解字》：考，老也；老，考也。", relatedIDs: [])
            ]
        ),
        MakingMethod(
            id: "loan", name: "假借", symbol: "arrow.triangle.swap",
            summary: "借一個同音字來用",
            detail: "有些詞有讀音卻沒有字，就借一個讀音相同的字來用，久了原本的意思反而被忘記。",
            examples: [
                MethodExample(character: "來", formula: "麥子 → 來", explanation: "本來畫的是麥子，被借去表示「來」。", relatedIDs: []),
                MethodExample(character: "其", formula: "畚箕 → 其", explanation: "本來是畚箕，被借走後只好另造「箕」。", relatedIDs: [])
            ]
        )
    ]
}

// MARK: - 字體年表
extension ScriptEra {
    static let all: [ScriptEra] = [
        ScriptEra(
            id: "oracle", name: "甲骨文", dynasty: "商", years: "約前 1300 – 前 1046",
            tool: "龜甲、獸骨 + 刀", toolSymbol: "scissors",
            description: "商朝王室占卜後，把問題和結果刻在龜甲與牛骨上。這是目前已知最早、成體系的漢字。",
            funFact: "1899 年，王懿榮在中藥材「龍骨」上發現了刻字，甲骨文才重見天日。",
            color: .brown, stage: .oracle
        ),
        ScriptEra(
            id: "bronze", name: "金文", dynasty: "商・周", years: "約前 1300 – 前 256",
            tool: "青銅器鑄造", toolSymbol: "flame",
            description: "鑄在青銅鐘、鼎上的文字，又叫「鐘鼎文」。因為是先做模再澆鑄，線條比甲骨文圓潤厚實。",
            funFact: "台北故宮的「毛公鼎」上有近 500 字銘文，是現存最長的金文之一。",
            color: .teal, stage: .bronze
        ),
        ScriptEra(
            id: "seal", name: "小篆", dynasty: "秦", years: "前 221 起",
            tool: "毛筆、竹簡", toolSymbol: "paintbrush.pointed",
            description: "秦始皇統一六國後，由李斯整理出統一的標準字體，也就是「書同文」。",
            funFact: "今天的印章常用篆書，所以刻印章也叫「篆刻」。",
            color: .indigo, stage: .seal
        ),
        ScriptEra(
            id: "clerical", name: "隸書", dynasty: "秦・漢", years: "約前 200 – 220",
            tool: "毛筆、竹簡", toolSymbol: "paintbrush.pointed",
            description: "為了寫得更快，圓轉的線條變成方折的筆畫，這個轉變叫「隸變」，是古文字與今文字的分水嶺。",
            funFact: "隸書的橫畫常有「蠶頭燕尾」：起筆像蠶頭，收筆像燕子尾巴。",
            color: .orange, stage: nil
        ),
        ScriptEra(
            id: "regular", name: "楷書", dynasty: "漢末・唐", years: "約 200 起，唐代成熟",
            tool: "毛筆、紙", toolSymbol: "doc.text",
            description: "筆畫端正、可以作為楷模，所以叫楷書。唐代的歐陽詢、顏真卿、柳公權都是楷書大師。",
            funFact: "電腦裡的「標楷體」就是楷書，我們今天寫的字也屬於楷書。",
            color: .red, stage: .regular
        ),
        ScriptEra(
            id: "running", name: "行書", dynasty: "東漢・魏晉", years: "約 200 起",
            tool: "毛筆、紙", toolSymbol: "pencil.and.scribble",
            description: "介於楷書和草書之間，寫得快又容易認，是日常最實用的手寫體。",
            funFact: "王羲之的《蘭亭集序》被稱為「天下第一行書」。",
            color: .green, stage: nil
        ),
        ScriptEra(
            id: "cursive", name: "草書", dynasty: "漢", years: "約前 100 起",
            tool: "毛筆、紙", toolSymbol: "scribble.variable",
            description: "為了寫得最快，筆畫大量連寫、省略，後來發展成奔放的藝術。",
            funFact: "唐代張旭、懷素的狂草，連當時的人都不一定看得懂。",
            color: .purple, stage: nil
        )
    ]
}
