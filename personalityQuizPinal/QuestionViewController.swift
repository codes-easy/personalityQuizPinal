//
//  QuestionViewController.swift
//  personalityQuizPinal
//
//  Created by user227975 on 10/7/22.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var SingleButton4: UIButton!
    @IBOutlet var SingleButton3: UIButton!
    @IBOutlet var singleButton2: UIButton!
    @IBOutlet var singleButton1: UIButton!
    
    @IBOutlet var mutlipleStackView: UIStackView!
    @IBOutlet var multiLabel1: UILabel!
    @IBOutlet var multiLabel2: UILabel!
    @IBOutlet var multiLable3: UILabel!
    @IBOutlet var multiLabel4: UILabel!
    
    
    @IBOutlet var multiSwitch1: UISwitch!
    
    @IBOutlet var multiSwitch2: UISwitch!
    
    
    @IBOutlet var multiSwitch3: UISwitch!
    @IBOutlet var multiSwitch4: UISwitch!
    
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabel1: UILabel!
    @IBOutlet var rangedLabel2: UILabel!
    
    @IBOutlet var questionProgressView: UIProgressView!
    
    var questionIndex = 0
    var answerChosen : [Answer] = []
    
    var questions : [Question] = [
        Question(text: "Which food do you like the most?",
                 type: .single,
                 answers: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
                 ]
                ),
        
        Question(text: "Which activities do you enjoy",
                 type: .multiple,
                 answers: [
                    Answer(text: "Swimming", type: .turtle),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cuddling", type: .rabbit),
                    Answer(text: "Eating", type: .dog)
                 ]
                ),
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answers: [
                    Answer(text: "I dislike thme", type: .cat),
                    Answer(text: "I get a little nervous", type: .rabbit),
                    Answer(text: "I barely notice them", type: .turtle),
                    Answer(text: "I love them", type: .dog)
                 ]
                )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answerChosen.append(currentAnswers[0])
        case singleButton2:
            answerChosen.append(currentAnswers[1])
        case SingleButton3:
            answerChosen.append(currentAnswers[2])
        case SingleButton4:
            answerChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion ()
    }
    
    
    @IBAction func multipleAnswerButtonPressed() {
           
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn
       {
            answerChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn
       {
            answerChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn
       {
            answerChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn
       {
            answerChosen.append(currentAnswers[3])
        }
        
        nextQuestion ()
    }

        
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangeSlider.value * Float(currentAnswers.count - 1)))
        answerChosen.append(currentAnswers[index])
       nextQuestion()
    }
    
    
    @IBOutlet var rangeSlider: UISlider!
    
    func updateUI(){
        singleStackView.isHidden = true
        mutlipleStackView.isHidden = true
        rangedStackView.isHidden=true
        
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float (questionIndex)/Float (questions.count)
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        /*switch currentQuestion.type{
         case .single:
         singleStackView.isHidden = false
         case .multiple:
         mutlipleStackView.isHidden = false
         case .ranged:
         rangedStackView.isHidden = false
         }*/
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
   
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultViewController? {
        return ResultViewController(coder: coder, responses: answerChosen)
    }

    func updateSingleStack(using answers : [Answer]){
        singleStackView.isHidden = false
        singleButton1.setTitle(answers [0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        SingleButton3.setTitle(answers[2].text, for: .normal)
        SingleButton4.setTitle(answers [3].text, for: .normal)
    }
    
    func updateMultipleStack (using answers: [Answer]){
        mutlipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLable3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]){
        rangedStackView.isHidden = false
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    func nextQuestion () {
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        }
        else{
            performSegue(withIdentifier: "Results", sender:nil)
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little
     
     preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}
