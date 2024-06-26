//
//  ContentView.swift
//  Guess The Flag App
//
//  Created by Mehmet Alp Sönmez on 21/05/2024.
//

import SwiftUI

struct ContentView: View {
   @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var questionNumber = 1
    @State private var questionLimit = false
    @State private var tappedFlag = -1
    
    @State private var showingAlert = false
    var body: some View {
        ZStack {
            //            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.25, blue: 0.45 ), location: 0.3),
                .init(color: Color(red: 0.75, green: 0.15, blue: 0.45 ), location: 0.3)],
                           
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.indigo)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundStyle(.black)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 10)
                                .rotation3DEffect(
                                    .degrees( tappedFlag == number ? 360:0),
                                                          axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                                )
                                .animation(.default, value: tappedFlag)
                                .opacity(tappedFlag == -1 ||  tappedFlag == number ? 1.0 : 0.25)
                                .scaleEffect(tappedFlag == -1 ||  tappedFlag == number ? 1.0 : 0.5)
                        }
                        .accessibilityLabel(labels[countries[number], default: "Unknown Flag"])
                        
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 50))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        }
        .alert("You have reached the end.Press Restart to start again. Your score: \(userScore)", isPresented: $questionLimit) {
            Button("Restart", action: restartTheGame)
        }
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "WRONG! That's the flag of \(countries[number])"
            if userScore <= 0 {
                userScore = 0
            } else {
                userScore -= 1
            }
        }
        if questionNumber < 8 {
            questionNumber += 1
            questionLimit = false
        } else {
            questionLimit = true

        }
        tappedFlag = number
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        tappedFlag = -1

    }
    func restartTheGame() {
        userScore = 0
        questionNumber = 1
        askQuestion()
    }
    
}
    

#Preview {
    ContentView()
}
