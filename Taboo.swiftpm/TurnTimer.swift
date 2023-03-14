import SwiftUI

struct TurnTimer: View {
    @Binding
    var seconds: Int?
    
    @Binding
    var paused: Bool
    
    var body: some View {
        let t = seconds ?? 0
        
        HStack {
            Text("\(t/60):\(t%60/10)\(t%10)")
                .font(.largeTitle.bold())
                .foregroundColor(t <= 5 ? someRed : Color.primary)
            
            Button {
                paused = !paused
            } label: {
                Image(systemName: paused ? "play.fill" : "pause.fill")
                //.font(.title)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.bordered)
            .disabled(t <= 0)
            .tint(.white)
        }
//        .onAppear {
//            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
//                time in
//                if !paused {
//                    if let t = seconds, t > 0 {
//                        seconds = t - 1
//                    }
//                }
//            }
//        }
    }
}

struct TurnTimer_Previews: PreviewProvider {
    @State
    static var full: Int? = 3*60

    @State
    static var short: Int? = 10

    @State
    static var expired: Int? = 0
    
    @State 
    static var paused: Bool = false
    
    static var previews: some View {
        VStack {
            TurnTimer(seconds: $full, paused: $paused)
            .padding()

            TurnTimer(seconds: $short, paused: $paused)
            .padding()

            TurnTimer(seconds: $expired, paused: $paused) 
            .padding()
        }
        .background(pokerGreen)
    }
}
