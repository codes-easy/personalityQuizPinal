//
//  ResultViewController.swift
//  personalityQuizPinal
//
//  Created by user227975 on 10/7/22.
//

import UIKit
class ResultViewController: UIViewController {
    var responses : [Answer]
    
    init?(coder: NSCoder, responses: [Answer]) {
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBOutlet var resultAnswerLabel: UILabel!
    
    @IBOutlet var resultDefinationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    func calculatePersonalityResult(){
        let frequencyOfAnswers = responses.reduce(into: [:] )
        { (counts, answer) in
            counts[answer.type, default:0]  += 1
            }
            
            let frequentAnswerSorted = frequencyOfAnswers.sorted (by :
                { (pair1, pair2) in
                return pair1.value > pair2.value
                
            })
            let mostCommonAnswer = frequentAnswerSorted.sorted{$0.1 > $1.1}.first!.key
         
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinationLabel.text = mostCommonAnswer.defination
        
        }
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
    

