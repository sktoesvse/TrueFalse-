//
//  QuestionsFile .swift
//  TrueFalseStarter
//
//  Created by Alex Koss on 9/12/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

struct PossibleAnswer {
    var possibleAnswer1: String
    var possibleAnswer2: String
    var possibleAnswer3: String
    var possibleAnswer4: String
}
class quizQuestions {
    let question:String
    let possibleAnswer: PossibleAnswer
    let rightAnswer:String
    
    init(question: String, possibleAnswer: PossibleAnswer, rightAnswer: String ) {
        self.question = question
        self.possibleAnswer = possibleAnswer
        self.rightAnswer = rightAnswer
        
    }
    
}



let questionOne = quizQuestions(question:  "Which destiny character comes to the tower every Friday and trades exotic items for strange coins? ", possibleAnswer: PossibleAnswer (possibleAnswer1:  "The Traveler", possibleAnswer2:  "The Speaker",  possibleAnswer3: "Xur", possibleAnswer4:  "None of the  above") ,  rightAnswer: "Xur")


let questionTwo = quizQuestions(question:  "Which is not a possible type of guardian? ",  possibleAnswer: PossibleAnswer (possibleAnswer1: "Hunter" ,  possibleAnswer2: "Wizard", possibleAnswer3 :"Warlock",  possibleAnswer4: "Titan"), rightAnswer: "Wizard")

let questionThree = quizQuestions(question: "Which exotic hand cannon is the only one to deal the damage over time effect?", possibleAnswer:PossibleAnswer(possibleAnswer1:  "Thorn", possibleAnswer2: "The Last Word", possibleAnswer3:  "HawkMoon" , possibleAnswer4: "The first Curse"), rightAnswer: "Thorn")

let questionFour = quizQuestions(question: "What highly coveted rocket launcher was not brought into year 2?", possibleAnswer:PossibleAnswer(possibleAnswer1: "The Truth", possibleAnswer2: "Tomorrows Answer", possibleAnswer3: "Gjallahorn", possibleAnswer4: "Dragons Breath"), rightAnswer: "Gjallahorn")
let questionFive = quizQuestions(question: "What was the name of the first raid in Destiny?", possibleAnswer: PossibleAnswer(possibleAnswer1: "Vault of glass", possibleAnswer2: "Crota's End", possibleAnswer3: "KingsFall", possibleAnswer4: "Wrath of the Machine"), rightAnswer: "Vault of glass")

let questionSix = quizQuestions(question: "What is the name of the raid in the Rise of Iron?", possibleAnswer: PossibleAnswer(possibleAnswer1: "Vault of glass", possibleAnswer2: "Crota's end", possibleAnswer3: "King's Fall", possibleAnswer4: "Wrath of the Machine"), rightAnswer: "Wrath of the Machine")

let questionSeven = quizQuestions(question: "What is the elemental archetype of the Hunter's Gunslinger subclass?", possibleAnswer: PossibleAnswer(possibleAnswer1: "Void", possibleAnswer2: "Solar", possibleAnswer3: "Arc", possibleAnswer4: "None of the above"), rightAnswer: "Solar")
let questionEight = quizQuestions(question: "How many wins(without Buffs or losses) are required to go to the Lighthouse in the Trials of Osiris?", possibleAnswer: PossibleAnswer(possibleAnswer1: "Five", possibleAnswer2: "Six", possibleAnswer3: "Nine", possibleAnswer4: "Seven"), rightAnswer: "Nine")


var destinyQuestions = [questionOne, questionTwo, questionThree, questionFour, questionFive, questionSix, questionSeven, questionEight]


