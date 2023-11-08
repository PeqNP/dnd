/// Copyright ⓒ 2023 Bithead LLC. All rights reserved.

import UIKit
import SpriteKit
import GameplayKit
import SimpleViewModel

class GameViewController: UIViewController {
    
    private lazy var viewModel = ViewModelInterface(viewModel: GameViewModel(), receive: receive)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene.newGameScene()

        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController {
    fileprivate func receive(output: GameViewModel.Output) {
        
    }
}
