
import UIKit
import GameKit
import AudioToolbox
import Foundation
class ViewController: UIViewController {
    
    let questionsPerRound = destinyQuestions.count
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var previousQuestions: [Int] = []
    var gameSound: SystemSoundID = 0
    var CorrectAnswer: SystemSoundID = 1
    var WrongAnswer: SystemSoundID = 2
    var PlayAgain: SystemSoundID = 3
    var PlayScorch: SystemSoundID = 4
    var PlayAlarm: SystemSoundID = 5
    var PlayCant: SystemSoundID = 6
    var PlayAmazing: SystemSoundID = 7
    var PlayEarn: SystemSoundID = 8
    var PlayYouAre: SystemSoundID = 9
    var PlayHive: SystemSoundID = 10
    var PlayEyesUp: SystemSoundID = 11
    var seconds = 15
    var timer = NSTimer()
    var timerActive = false
    
   @IBOutlet weak var questionField: UILabel!
   @IBOutlet weak var ButtonA: UIButton!
    @IBOutlet weak var ButtonB: UIButton!
    @IBOutlet weak var ButtonC: UIButton!
    @IBOutlet weak var ButtonD: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      loadGameStartSound()
//         Start game
       playGameStartSound()
        displayQuestion()
  //sound Functions
    loadPlayCorrectSound()
    loadPlayWrongSound()
    loadPlayAgain()
    loadPlayScorch()
    loadPlayCant()
    loadPlayEarn()
    loadPlayAlarm()
    loadPlayYouAre()
    loadPlayAmazing()
    loadPlayHive()
    loadPlayEyesUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
      ///Randomly generates questions from questionfile.
        
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(destinyQuestions.count)
        while previousQuestions.contains(indexOfSelectedQuestion) {
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(destinyQuestions.count)
        }
        ///Takes questions that have been already asked out of the index.
        previousQuestions.append(indexOfSelectedQuestion)
        
        let questionDictionary = destinyQuestions[indexOfSelectedQuestion]
        questionField.text = questionDictionary.question
        
        playAgainButton.hidden = true
        //// Live Buttons
    ButtonA.setTitle(questionDictionary.possibleAnswer.possibleAnswer1, forState: UIControlState.Normal)
    ButtonB.setTitle(questionDictionary.possibleAnswer.possibleAnswer2, forState: UIControlState.Normal)
    ButtonC.setTitle(questionDictionary.possibleAnswer.possibleAnswer3, forState: UIControlState.Normal)
    ButtonD.setTitle(questionDictionary.possibleAnswer.possibleAnswer4, forState: UIControlState.Normal)
        resetTimer()
        startTimer()
    }
    func displayScore() {
        // Hide the answer buttons
        ButtonA.hidden = true
        ButtonB.hidden = true
        ButtonC.hidden = true
        ButtonD.hidden = true
        //timerActive = false
        timerLabel.hidden = true
       playAgainButton.hidden = false
       /// Using else if statements to give the user a special unique audio and visual messages based on the score of the game.
        if correctQuestions >= 8 {
          questionField.text = "Boom! You got all \(correctQuestions) correct! "
        playscorch()
        } else if correctQuestions >= 7 {
            questionField.text = " You did awesome with \(correctQuestions) right!"
       playamazing()
        } else if correctQuestions >= 5 {
            questionField.text = "You did better than average with \(correctQuestions) right!"
       playcant()
        } else if correctQuestions >= 3 {
            questionField.text = "Only \(correctQuestions) correct? That has to be wrong?"
        playyouare()
        } else if correctQuestions >= 1 {
            questionField.text = "Really only \(correctQuestions) questions right?"
        playearn()
        }   else {
            questionField.text = "Are you there?"
        playalarm()
        }
        //questionField.text = "Way to go Guardian! You \(correctQuestions) correct! "
        //questionField.text = "Way to go guardian!\nYou got \(correctQuestions) out of \(questionsPerRound) correct! "
        }
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        ///loads special sounds if the user is correct or incorrect. Stops the time after each question is answered.
        questionsAsked += 1
        let selectedQuestionDict = destinyQuestions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.rightAnswer
        if (sender.titleLabel!.text == correctAnswer) {
            correctQuestions += 1
            playCorrectSound()
           ////Shows active score in the questionField to save room. :-)
            questionField.text =  "\(correctQuestions) out of 8 correct! You have \(8 - previousQuestions.count ) questions to go Guardian!"
        timer.invalidate()
        
        } else {
           playWrongSound()
            //sender.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            questionField.text = "Wrong answer! You have \(correctQuestions) questions out of 8 correct! \(8 - previousQuestions.count) questions remain!"
            //questionField.textColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
            timerLabel.text = "The correct answer is \(correctAnswer.capitalizedString)"
            timer.invalidate()
        }
    //questionsAsked += 1
    //destinyQuestions.removeAtIndex(indexOfSelectedQuestion)
   loadNextRoundWithDelay(seconds: 2)
        }
    ///Evaluates whether or not the game is over. If it is then it displays the score, If not it continues.
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
    }
      }
    @IBAction func playAgain() {
        // Show the answer buttons and restarts the game with a special sound effect.
        ButtonA.hidden = false
        ButtonB.hidden = false
        ButtonC.hidden = false
        ButtonD.hidden = false
        questionField.hidden = false
        timerLabel.hidden = false
        questionsAsked = 0
        correctQuestions = 0
        indexOfSelectedQuestion = 0
        previousQuestions = []
        /////Loads sound when restarting game.
        playagain()
        nextRound()
        }
 
    ///Using a function with NSTimer to begin the time at the beginning of each question.
    func startTimer() {
        if timerActive == false {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
            timerActive = true
        }
        }
//using the updateTimer function to give keep track of time and displaying the timeleft in the timer.label
    func updateTimer() {
        let selectedQuestionDict = destinyQuestions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.rightAnswer
        
        seconds -= 1
        timerLabel.text = "You have \(seconds) seconds to go!"
        if seconds == 0 {
            playhive()
            timer.invalidate()
            //// If the user runs out of time it displays the amount of questions answered correctly in the timerlabel.
            timerLabel.text = "Out of time! You have \(correctQuestions) questions out of 8 correct! \(8 - previousQuestions.count) questions remain!"
            ///Using the question field to display the capitalized correct answer and heckle the user if time runs out.
            questionField.text = "Gotta be quicker! The correct answer is \(correctAnswer.capitalizedString)"
            
            questionsAsked += 1
            loadNextRoundWithDelay(seconds: 3)
     ///       Using else if statements to give visual and audio alerts that time is running out.
        } else if seconds <= 6 {
            timerLabel.text = " \(seconds)..... "
            playalarm()
        } else if  seconds == 10 {
        playeyesup()
            }
           }
    /// reseting timer after each questions and game.
    func resetTimer() {
        seconds = 15
        ///Added the timerLabel text that matches that matches the update timer's text because there was a wierd skip between reset and start.
        timerLabel.text = "You have \(seconds) seconds to go!"
        timerActive = false
        }
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
//////////// soundfile functions to correspond to different audio files based on user interaction

    func loadGameStartSound() {
       let pathToSoundFile = NSBundle.mainBundle().pathForResource("DestinyTheme", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    func loadPlayCorrectSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("correct", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &CorrectAnswer)
    }
    func playCorrectSound() {
        AudioServicesPlaySystemSound(CorrectAnswer)
    }
    func loadPlayWrongSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("Wrong", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &WrongAnswer)
        }
    func playWrongSound() {
        AudioServicesPlaySystemSound(WrongAnswer)
    }
    func loadPlayAgain() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("Restart", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &PlayAgain)
    }
    func playagain() {
        AudioServicesPlaySystemSound(PlayAgain)
}
    func loadPlayScorch() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("Scorch", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &PlayScorch)
    }
    func playscorch() {
        AudioServicesPlaySystemSound(PlayScorch)
    }
    func loadPlayAmazing() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("Amazing", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &PlayAmazing)
    }
    func playamazing() {
        AudioServicesPlaySystemSound(PlayAmazing)
    }
        func loadPlayCant() {
            let pathToSoundFile = NSBundle.mainBundle().pathForResource("Cant", ofType: "mp3")
            let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
            AudioServicesCreateSystemSoundID(soundURL, &PlayCant)
        }
        func playcant() {
            AudioServicesPlaySystemSound(PlayCant)
        }
    
    func loadPlayYouAre() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("Youare", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &PlayYouAre)
    }
    func playyouare() {
        AudioServicesPlaySystemSound(PlayYouAre)
    }
    func loadPlayAlarm() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("Alarm", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &PlayAlarm)
    }
    func playalarm() {
        AudioServicesPlaySystemSound(PlayAlarm)
    }
    func loadPlayEarn() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("Earn", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &PlayEarn)
    }
    func playearn() {
        AudioServicesPlaySystemSound(PlayEarn)
    }
    func loadPlayHive() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("Hive", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &PlayHive)
    }
    func playhive() {
        AudioServicesPlaySystemSound(PlayHive)
    }
    func loadPlayEyesUp() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("Eyesup", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &PlayEyesUp)
    }
    func playeyesup() {
        AudioServicesPlaySystemSound(PlayEyesUp)
    }
    }