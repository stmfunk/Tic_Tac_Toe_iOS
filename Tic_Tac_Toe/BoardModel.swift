//
//  BoardModel.swift
//  Tic_Tac_Toe
//
//  Created by Donal O'Shea on 24/04/2019.
//  Copyright © 2019 Menishi. All rights reserved.
//

import UIKit

enum Player {
    case Nought
    case Cross
    case Empty
}

class BoardModel: NSObject {
    private var playerTurn: Player = Player.Nought;
    internal var allCells: [Player] = Array(repeating: Player.Empty, count: 9);

    public func resetBoard() {
        self.allCells = Array(repeating: Player.Empty, count: 9);
    }
    
    
    
    
    
    public func assessBoard() -> Player {
        // Calls a series of helper functions to assess the logical constraints of a winning game
        var gameWon = false;
        for i in 0...6 {
            if (i < 3) {gameWon = gameWon || assessVertical(offset: i);}
            if (i % 3 == 0) {gameWon = gameWon || assessHorizontal(offset:i)}
            if (i == 0 || i == 2) {gameWon = gameWon || assessDiagonal(offset:i)}
            if gameWon {
                return allCells[i];
            }
        }
        return Player.Empty;
    }
    
    internal func assessVertical(offset:Int) -> Bool {
        return allCells[offset] != Player.Empty && (allCells[offset],allCells[offset+3])==(allCells[offset+3], allCells[offset+6])
    }
    
    internal func assessHorizontal(offset:Int) -> Bool {
        return allCells[offset] != Player.Empty && (allCells[offset],allCells[offset+1])==(allCells[offset+1], allCells[offset+2])
    }
    
    internal func assessDiagonal(offset:Int) -> Bool {
        return allCells[offset] != Player.Empty && (allCells[offset],allCells[4])==(allCells[4], allCells[8-offset])
    }
    
    public func getTurn() -> Player {
        self.playerTurn = self.playerTurn == Player.Nought ? Player.Cross : Player.Nought;
        return self.playerTurn;
    }

    
    public func updateCell(cellNo:Int) {
        self.allCells[cellNo-1] = self.playerTurn;
    }
}
