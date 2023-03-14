import SwiftUI

struct Card: View {
    var word: String
    var taboo: [String]
    var faceUp = true

    var body: some View {
        VStack {
            if faceUp {
                VStack {
                    Text(word)
                        .font(.title)
                        .padding()

                    ForEach(Array(taboo.enumerated()), id: \.0) { (i, w) in
                        Text(w)
                            .font(.title2)
                    }
                }
            }
            else {
                VStack(spacing: 30) {
                    // Image("logo.svg")
                    //     .resizable()
                    //     .scaledToFit()
                    //     .padding()

                    Text("OB Anesthesia")
                        .font(Font.custom("Times New Roman", size: 32))
                }
                .foregroundColor(logoBlue)
            }
        }
        .padding()
        .frame(width: 280, height: 420)
        .background(faceUp ? Color.white : Color(white: 0.8))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 2)
        )
    }
}

struct CardStack: View {
    /// If the top card is nil, the stack is treated as empty
    var top: Card?
    var count: Int

    var body: some View {
        if count > 0, let top = top {
            ZStack {
                ForEach(Array(0 ..< (count-1)), id: \.self) { i in
                    Card(word: "", taboo: [], faceUp: top.faceUp)
                        .offset(x: 0, y: CGFloat((count-1-i)*10))
                    //                    .id(hidden - i)
                }

                top
//                    .offset(x: 0, y: 0)
                //                .id(0)
                //                .offset(x: 0, y: CGFloat(-hidden*10))
            }
        } else {
            emptyCard.opacity(0.0)
        }
    }
}

let emptyCard = Card(word: "", taboo: [], faceUp: false)

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack(spacing: 40) {
                Card(word: "", taboo: [], faceUp: false)
                Card(word: "Foo", taboo: ["bar", "baz"], faceUp: true)
            }

            HStack(spacing: 40) {
                CardStack(
                    top: Card(word: "", taboo: [], faceUp: false), count: 5)
                CardStack(
                    top: Card(word: "Foo", taboo: ["bar", "baz"], faceUp: true), count: 3)
            }
        }
    }
}
