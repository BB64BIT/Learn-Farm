//
//  PopUpViewController.swift
//  Learn Farm
//
//  Created by Michele Colelli Riano on 21/02/2018.
//  Copyright © 2018 Mik Colelli Riano. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    let questionCow = ["la mucca fa...","biagio è strunz"]
    let answerCow = [["mu mu","bu bu","tu tu"],["si","no","forse"]]
    
    var currentQuestions = 0
    var rightAnswer:UInt32 = 0
    
    @IBOutlet weak var PopUpView: UIView!
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answer1: UIButton!
    
    @IBOutlet weak var answer2: UIButton!
    
    
    @IBOutlet weak var answer3: UIButton!
    
   
    @IBAction func answerButton(_ sender: UIButton) {
        if ((sender as AnyObject).tag == Int(rightAnswer) && answer1.tag == (sender as AnyObject).tag )
            
        {
            
            sender.backgroundColor = UIColor.green
           
            sender.isEnabled = false
            answer2.isEnabled = false
            answer3.isEnabled = false
            
            closeOutlet.isHidden = false
         
            
            
        }
        else {
            
            sender.isEnabled = false
            sender.backgroundColor = UIColor.red
            
            if ((sender as AnyObject).tag == Int(rightAnswer) && answer2.tag == (sender as AnyObject).tag )
                
            {
                
                sender.backgroundColor = UIColor.green
                
                sender.isEnabled = false
                answer1.isEnabled = false
                answer3.isEnabled = false
                
                closeOutlet.isHidden = false
            
            }else{
                sender.isEnabled = false
                sender.backgroundColor = UIColor.red
                
                if ((sender as AnyObject).tag == Int(rightAnswer) && answer3.tag == (sender as AnyObject).tag )
                    
                {
                    
                    sender.backgroundColor = UIColor.green
                    
                    sender.isEnabled = false
                    answer1.isEnabled = false
                    answer2.isEnabled = false
                    
                    closeOutlet.isHidden = false
                    
                }
            }
        
        }
        
    }
    
    
    @IBOutlet weak var closeOutlet: UIButton!
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        closeOutlet.isHidden = true
        if ARkitViewController.share.nodeName == "COWBODY" {
            currentQuestions = 1
       newQuestion()
          
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newQuestion()    {
        
        
        questionLabel.text = questionCow[currentQuestions]
        
        rightAnswer = arc4random_uniform(3)+1
        
        //        button creation
        
        var button:UIButton = UIButton()
        
        var x = 1
        
        for i in 1...3
        {
            
            button = view.viewWithTag(i) as! UIButton
            
            if (i == Int(rightAnswer)){
                
                button.setTitle(answerCow[currentQuestions][0], for: .normal)
            }
                
            else{
                
                button.setTitle(answerCow[currentQuestions][x], for: .normal)
                x += 1
            }
            
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
