//
//  ARkitViewController.swift
//  Learn Farm
//
//  Created by Michele Colelli Riano on 21/02/2018.
//  Copyright © 2018 Mik Colelli Riano. All rights reserved.
//

import UIKit
import ARKit
import AVFoundation

class ARkitViewController: UIViewController, ARSCNViewDelegate {
    
    static let share = ARkitViewController()
    
    var nodeName: String = ""
    
    
    @IBOutlet weak var ARScene: ARSCNView!
    
    
    let cowMapName = ["COWBODY_003", "COWBODY_002", "COWBODY_001", "COWBODY"]
    let sheepMapName = ["Sheep_006", "Sheep_005", "Sheep_004", "Sheep_003", "Sheep_002", "Sheep_001", "Sheep"]
    let pigMapName = ["pig_004", "pig_003", "pig_002", "pig_001", "pig"]
    let gallinaMapName = ["Gallina_003", "Gallina_002", "Gallina_001", "Gallina"]
    let configuration = ARWorldTrackingConfiguration()
    var showed: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ARScene.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.ARScene.session.run(configuration)
        self.ARScene.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.ARScene.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        if hitTest.isEmpty {
            print("didn't touch anything")
        } else {
            let results = hitTest.first!
            let node = results.node
            if node.name != nil {
                if cowMapName.contains(node.name!) {
                    playSound(sound: "Cow")
                    if node.name! == "COWBODY" {
                       
                        ARkitViewController.share.nodeName = node.name!
                        
                        let viewController:UIViewController = UIStoryboard(name: "ARkit", bundle: nil).instantiateViewController(withIdentifier: "PopUp") as UIViewController
                        
                        let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.crossDissolve
                        viewController.modalTransitionStyle = modalStyle
                        self.present(viewController, animated: true, completion: nil)
                    }
                }
                
                if sheepMapName.contains(node.name!) {
                    playSound(sound: "Sheep")
                    ARkitViewController.share.nodeName = node.name!
                }
                
                if pigMapName.contains(node.name!) {
                    playSound(sound: "Pig")
                    ARkitViewController.share.nodeName = node.name!
                }
                
                if gallinaMapName.contains(node.name!) {
                    playSound(sound: "Chicken")
                    ARkitViewController.share.nodeName = node.name!
                }
            }
            
            //            if node.name == "CowBlW" {
            //                print("e tuccat a mucc")
            //                if self.askView.isHidden == true {
            //                UIView.transition(with: askView, duration: 0.4, options: .transitionCurlDown, animations: {() -> Void in
            //                    self.askView.isHidden = false
            //                })
            
            //                }
            //            }else{
            //                self.askView.isHidden = true
            //            }
        }
    }
    
    
    
    
    func createFarm(planeAnchor: ARPlaneAnchor) -> SCNNode {
        let scene = SCNScene(named: "Art.scnassets/maps.scn")
        let node = (scene?.rootNode.childNode(withName: "start", recursively: false))!
        node.position = SCNVector3(planeAnchor.center.x,planeAnchor.center.y,planeAnchor.center.z)
        //node.eulerAngles = SCNVector3(180.degreesToRadians, 0, 0)
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if showed == false {
            guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
            let farmNode = createFarm(planeAnchor: planeAnchor)
            //        let cowNode = addNode(planeAnchor: planeAnchor, path: "Models.scnassets/mucca.scn", name: "Mucca")
            node.addChildNode(farmNode)
            //        node.addChildNode(cowNode)
            print("new flat surface detected, new ARPlaneAnchor added")
            showed = true
        }
        
    }
    
    //    func addNode(planeAnchor: ARPlaneAnchor, path: String, name: String) -> SCNNode {
    //        let genericScene = SCNScene(named: path)
    //        let genericNode = (genericScene?.rootNode.childNode(withName: name, recursively: false))!
    //        genericNode.position = SCNVector3(planeAnchor.center.x - 4.8, planeAnchor.center.y, planeAnchor.center.z + 1.8)
    //        //genericNode.eulerAngles = SCNVector3(0,0,0)
    //        return genericNode
    //    }
    

    
    var player: AVAudioPlayer?
    
    func playSound(sound: String) {
        guard let url = Bundle.main.url(forResource: "Sounds/" + sound, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

    
    

}

