//
//  ViewController.swift
//  Tic_Tac_Toe
//
//  Created by Donal O'Shea on 09/04/2019.
//  Copyright © 2019 Menishi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var board: BoardModel = BoardModel();
    
    // Outlet collection for convenient updating of the board view
    @IBOutlet var allCells: [UIImageView]!
    @IBOutlet weak var boardView: UIImageView!
    @IBOutlet weak var victoryLabel: UILabel!
    
    // Constraint outlets allows us to animate using autolayout
    @IBOutlet weak var vicLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var vicLabelTrailingConstraint: NSLayoutConstraint!

    @IBOutlet weak var turnLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.turnLabel.text = "Crosses Turn";
        
    }

    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imgv = sender.view as! UIImageView;
        
        // Control over player turn is confined to board model
        let turn = self.board.getTurn();
        
        
        
        if turn == Player.Nought {
            imgv.image = UIImage(named: "nought.png");
            self.turnLabel.text = "Crosses Turn";
            imgv.isUserInteractionEnabled = false;
            
        } else {
            // Update the view and disable taps on square
            imgv.image = UIImage(named: "cross.png");
            self.turnLabel.text = "Noughts Turn";
            imgv.isUserInteractionEnabled = false;
        }
        
        // Match model to view
        self.board.updateCell(cellNo: imgv.tag);
        
        
        // Board determines if a player has won
        let status = self.board.assessBoard();
        if status != Player.Empty {
            if status == Player.Nought {
                self.victoryLabel.text = "Noughts Won!"
            } else if status == Player.Cross {
                self.victoryLabel.text = "Crosses Won!"
            }
            self.vicLabelLeadingConstraint.constant = 0;
            self.vicLabelTrailingConstraint.constant = 0;
            
            // Animate in a victory banner and fade out the board
            UIView.animate(withDuration: 0.5, animations:{
                self.boardView.alpha = 0.5;
                self.view.layoutIfNeeded();
                for imgv in self.allCells {
                    imgv.isUserInteractionEnabled = false;
                    imgv.alpha = 0.5;
                }
            });
        }
    }
    @IBAction func resetBoard(_ sender: Any) {
        board.resetBoard();
        UIView.animate(withDuration: 0.5, animations:{
            self.boardView.alpha = 1;

            self.vicLabelLeadingConstraint.constant = -375;
            self.vicLabelTrailingConstraint.constant = -375;
            for imgv in self.allCells {
                imgv.isUserInteractionEnabled = true;
                imgv.alpha = 1;
                imgv.image = UIImage(named:"");
                self.view.layoutIfNeeded();
            }
        });
        
        self.turnLabel.text = "Crosses Turn";
    }

}

