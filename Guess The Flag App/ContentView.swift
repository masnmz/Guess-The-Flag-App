//
//  ContentView.swift
//  Guess The Flag App
//
//  Created by Mehmet Alp Sönmez on 21/05/2024.
//

import SwiftUI

struct ContentView: View {
   @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var questionNumber = 1
    @State private var questionLimit = false
    
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
                            .foregroundStyle(.purple)
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
                        }
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
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

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
