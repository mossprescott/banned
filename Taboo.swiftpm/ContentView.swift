import SwiftUI

let TIME_LIMIT = 3*60

// #00356B
let logoBlue = Color(red: 0, green: 0.207, blue: 0.406)

let pokerGreen = Color(red: 0.28, green: 0.44, blue: 0.28)
let someRed = Color(hue: 0, saturation: 0.65, brightness: 0.50)

struct ContentView: View {
    var cards: [Card] = words

    @State
    var faceUp: Int = 0

    @State
    var discarded: Int = 0

    /// Seconds remaining in the turn
    @State
    var timer: Int? = nil

    @State
    var paused: Bool = false

    var body: some View {
        let faceDownCount = cards.count - faceUp - discarded

        VStack(spacing: 20) {
            HStack {
                if faceUp > 0 {
                    Text("\(faceUp)")
                        .font(.title)
                }
            }
            .frame(minHeight: 50)

            HStack(spacing: 50) {
                CardStack(top: emptyCard,
                          count: faceDownCount)

                CardStack(top: faceUp > 0
                              ? cards[discarded + faceUp - 1]
                              : nil,
                          count: faceUp)

                CardStack(top: emptyCard,
                          count: discarded)
            }

            HStack(spacing: 50) {
                if timer == nil {
                    BigButton(label: "Start Turn") {
                        timer = TIME_LIMIT
                        faceUp += 1
                    }
                }
                else if timer == 0 {
                    BigButton(label: "End Turn") {
                        discarded += faceUp
                        faceUp = 0
                        timer = nil
                    }
                }
            }
            .frame(minHeight: 100)
            .padding(EdgeInsets(top: 200, leading: 10, bottom: 20, trailing: 10))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(pokerGreen)
        .overlay {
            if timer != nil {
                TurnTimer(seconds: $timer, paused: $paused)
                    .position(x: 100, y: 50)
            }
        }
        .onTapGesture {
            if let timer = timer, timer > 0 && !paused {
                if faceUp + discarded < cards.count {
                    faceUp += 1
                }
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
                time in
                if !paused, let t = timer, t > 0 {
                    timer = t - 1
                }
            }
        }
    }
}


struct BigButton: View {
    var label: String

    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.largeTitle)
                .padding()
                .background(Color.cyan)
                .cornerRadius(10)
                .foregroundColor(.white)
        }
    }
}
