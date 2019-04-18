//
//  ViewController.swift
//  ARTestingTemplate
//
//  Created by Rafael Lucena on 4/8/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBAction func btRua(_ sender: UIButton) {
        
        if(vectorPlane != nil){
            
            self.identifier = 0
            self.addBox(vectorPlane)
        }
    }

    @IBAction func btCasa(_ sender: UIButton) {
        
        if(vectorPlane != nil){
            self.identifier = 1
            self.addCasa1(vectorPlane)
        }
    }
    
    @IBAction func btCasa2(_ sender: UIButton) {
        if(vectorPlane != nil){
            self.identifier = 2
            self.addCasa2(vectorPlane)
        }
    }
    
    @IBAction func btPredio(_ sender: UIButton) {
        if(vectorPlane != nil){
            self.identifier = 3
            self.addPredio1(vectorPlane)
        }
    }
    
    @IBAction func btPredio2(_ sender: UIButton) {
        if(vectorPlane != nil){
            self.identifier = 4
            self.addPredio2(vectorPlane)
        }
    }
    
    @IBAction func btPredio3(_ sender: UIButton) {
        if(vectorPlane != nil){
            self.identifier = 5
            self.addPredio3(vectorPlane)
        }
    }
    
    
    @IBAction func btDemolir(_ sender: UIButton) {
        self.demolir()
    }
    
    
    @IBOutlet var sceneView: ARSCNView!
    
    var PCoordx: Float = 0.0
    var PCoordy: Float = 0.0
    var PCoordz: Float = 0.0

    var mainNode: SCNNode = SCNNode()
    var casa1: SCNNode = SCNNode()
    var casa2: SCNNode = SCNNode()
    var predio1: SCNNode = SCNNode()
    var predio2: SCNNode = SCNNode()
    var predio3: SCNNode = SCNNode()
    var planeNode: SCNNode = SCNNode()
    
    var vectorPlane : SCNVector3!
    var identifier = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.debugOptions = [SCNDebugOptions.showFeaturePoints]

        sceneView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDragGesture(_:))))
    }
    

    
    @objc func handleDragGesture(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            let hitNode = self.sceneView.hitTest(sender.location(in: self.sceneView),
                                                 options: nil)
            self.PCoordx = (hitNode.first?.worldCoordinates.x)!
            self.PCoordy = (hitNode.first?.worldCoordinates.y)!
            self.PCoordz = (hitNode.first?.worldCoordinates.z)!
        case .changed:
            // when you start to pan in screen with your finger
            // hittest gives new coordinates of touched location in sceneView
            // coord-pcoord gives distance to move or distance paned in sceneview
            let hitNode = sceneView.hitTest(sender.location(in: sceneView), options: nil)
            if let coordx = hitNode.first?.worldCoordinates.x,
                let coordy = hitNode.first?.worldCoordinates.y,
                let coordz = hitNode.first?.worldCoordinates.z {
                let action = SCNAction.moveBy(x: CGFloat(coordx - PCoordx),
                                              y: CGFloat(coordy - PCoordy),
                                              z: CGFloat(coordz - PCoordz),
                                              duration: 0.0)
                
                if(self.identifier == 0){
                    self.mainNode.runAction(action)
                }
                if(self.identifier == 1){
                    self.casa1.runAction(action)
                }
                if(self.identifier == 2){
                    self.casa2.runAction(action)
                }
                if(self.identifier == 3){
                    self.predio1.runAction(action)
                }
                if(self.identifier == 4){
                    self.predio2.runAction(action)
                }
                if(self.identifier == 5){
                    self.predio3.runAction(action)
                }
//
                self.PCoordx = coordx
                self.PCoordy = coordy
                self.PCoordz = coordz
            }
            
            sender.setTranslation(CGPoint.zero, in: self.sceneView)
        case .ended:
            
            self.PCoordx = 0.0
            self.PCoordy = 0.0
            self.PCoordz = 0.0
        default:
            

            break
        }
    }
    
            private func importEarth(_ vector :SCNVector3) {
                let scene = SCNScene(named: "art.scnassets/Earth.dae")!
    
                if let mainNode = scene.rootNode.childNode(withName: "Earth", recursively: true) {
                    mainNode.position = vector

                    sceneView.scene.rootNode.addChildNode(mainNode)
                }
            }
    
   
    func addBox(_ vector :SCNVector3) {
        let box = SCNBox(width: 0.02, height: 0, length: 0.1, chamferRadius: 0)
        let material = SCNMaterial()
        
        material.diffuse.contents = UIImage(named: "art.scnassets/3DModels/Asphalt_New.jpg")
        
        
        box.materials = [material]
        
        self.mainNode = SCNNode()
        mainNode.geometry = box
        mainNode.position = vector
        //        let scene = SCNScene()
        //        scene.rootNode.addChildNode(mainNode)
        sceneView.scene.rootNode.addChildNode(mainNode)
    }
    
    func addCasa1(_ vector :SCNVector3) {
        let box = SCNBox(width: 0.03, height: 0.03, length: 0.03, chamferRadius: 0)
        let material = SCNMaterial()
        
//        material.diffuse.contents = UIColor.purple
        material.diffuse.contents = UIImage(named: "art.scnassets/3DModels/material_1.jpg")
        
        box.materials = [material]
        
        self.casa1 = SCNNode()
        casa1.geometry = box
        casa1.position = vector
        //        let scene = SCNScene()
        //        scene.rootNode.addChildNode(mainNode)
        sceneView.scene.rootNode.addChildNode(casa1)
    }
    
    func addCasa2(_ vector :SCNVector3) {
        let box = SCNBox(width: 0.04, height: 0.05, length: 0.04, chamferRadius: 0)
        let material = SCNMaterial()
        
        material.diffuse.contents = UIImage(named: "art.scnassets/3DModels/Roofing_Shingles_GAF_Estates.jpg")
        
        box.materials = [material]
        
        self.casa2 = SCNNode()
        casa2.geometry = box
        casa2.position = vector
        
        sceneView.scene.rootNode.addChildNode(casa2)
    }
    
    func addPredio1(_ vector :SCNVector3) {
        let box = SCNBox(width: 0.04, height: 0.08, length: 0.03, chamferRadius: 0)
        let material = SCNMaterial()
        
        material.diffuse.contents = UIImage(named: "art.scnassets/3DModels/Concrete_Form_4x8.jpg")
        
        box.materials = [material]
        
        self.predio1 = SCNNode()
        predio1.geometry = box
        predio1.position = vector
        
        sceneView.scene.rootNode.addChildNode(predio1)
    }
    
    func addPredio2(_ vector :SCNVector3) {
        let box = SCNBox(width: 0.05, height: 0.09, length: 0.05, chamferRadius: 0)
        let material = SCNMaterial()
        
        material.diffuse.contents = UIImage(named: "art.scnassets/3DModels/Cladding_Siding_White.jpg")
        
        box.materials = [material]
        
        self.predio2 = SCNNode()
        predio2.geometry = box
        predio2.position = vector
        
        sceneView.scene.rootNode.addChildNode(predio2)
    }
    
    func addPredio3(_ vector :SCNVector3) {
        let box = SCNBox(width: 0.03, height: 0.1, length: 0.03, chamferRadius: 0)
        let material = SCNMaterial()
        
        material.diffuse.contents = UIImage(named: "art.scnassets/3DModels/Wood_Floor_Dark.jpg")
        
        box.materials = [material]
        
        self.predio3 = SCNNode()
        predio3.geometry = box
        predio3.position = vector
        
        sceneView.scene.rootNode.addChildNode(predio3)
    }
    
// private func createCube(){
//        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
//
//        let material = SCNMaterial()
//
//        material.diffuse.contents = UIColor.green
//
//        cube.materials = [material]
//
//        let numberZ = Int.random(in: -10 ..< 10)
//        let numberY = Int.random(in: -20 ..< 20)
//        let numberX = Int.random(in: -3 ..< 3)
//
//        self.mainNode = SCNNode()
//        self.mainNode.position = SCNVector3(numberX, numberY, numberZ)
//
//        self.mainNode.geometry = cube
//
//        sceneView.scene.rootNode.addChildNode(self.mainNode)
//        sceneView.automaticallyUpdatesLighting = true
//    }
//    private func importEarth(_ vector :SCNVector3) {
//        let scene = SCNScene(named: "art.scnassets/Earth.dae")!
//
//        if let earthNode = scene.rootNode.childNode(withName: "Earth", recursively: true) {
//            earthNode.position = vector
//
//            let moveUp = SCNAction.move(by: SCNVector3(0,1,0), duration: 3)
//            earthNode.runAction(moveUp) {
//                let action = SCNAction.rotateBy(x: 0, y: CGFloat(2 * Double.pi), z: 0, duration: 10)
//                let repAction = SCNAction.repeatForever(action)
//
//
//                earthNode.runAction(repAction)
//
//
//            }
//
//            sceneView.scene.rootNode.addChildNode(earthNode)
//        }
//    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let touchLocation = touch.location(in: sceneView)
//
//            let results = sceneView.hitTest(touchLocation, types: ARHitTestResult.ResultType.existingPlaneUsingExtent)
//
//            if let hitResult = results.first {
//                //                print(hitResult)
//
//                // create your object here
//
//                let vector = SCNVector3(
//                    hitResult.worldTransform.columns.3.x,
//                    hitResult.worldTransform.columns.3.y+0.05,
//                    hitResult.worldTransform.columns.3.z
//                )
//                addBox(vector)
//            }
//        }
//    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let anchor = anchor as? ARPlaneAnchor {
            createPlane(node: node, anchor: anchor)
        }
    }
  
    private func createPlane(node: SCNNode, anchor: ARPlaneAnchor) {
        let plane = SCNPlane(width: 0.3, height: 0.3)
        
        
        planeNode.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        vectorPlane = planeNode.position
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.white
        
        plane.materials = [material]
        planeNode.geometry = plane
        
        node.addChildNode(planeNode)
    }
    
    func demolir(){
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
//            if(node != planeNode){
                node.removeFromParentNode()
//            }
            
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
