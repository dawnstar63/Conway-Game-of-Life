//
//  GameScene.swift
//  Conway Game of Life
//
//  Created by Elena Ariza on 3/11/16.
//  Copyright (c) 2016 Elena Ariza and Shannon Shih. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var world: World!
    var gridCoord = [[CGPointMake(0,0)]]
    
    let margin: CGFloat = 20
    let upperSpace: CGFloat = 100
    let spaceBetwCells: CGFloat = 1.4
    var cellSize: CGFloat = 0
    
//    let cellLayer = SKNode()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize)
    {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0, y: 1.0)
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 0, y: 0)
        background.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        addChild(background)
        
//        cellLayer.position = CGPoint(x: 50, y: 50)
//        addSpritesForCells(world.board)
//        addChild(cellLayer)
        
    }
    
//    func addSpritesForCells(cells: [[Cell]])
//    {
//        var cellArray = cells
//        for row in 0...cells.count
//        {
//            for col in 0...cells[0].count
//            {
//                var sprite: SKSpriteNode!
//                if world.board[row][col].state == DEAD {
//                    sprite = SKSpriteNode(imageNamed: "dead")
//                }
//                else if world.board[row][col].state == P1 {
//                    sprite = SKSpriteNode(imageNamed: "player 1")
//                }
//
//                let leftCornerCell = margin + CGFloat(col) * (cellSize + spaceBetwCells)
//                let upperCornerCell = upperSpace + CGFloat(row) * (cellSize + spaceBetwCells)
//
//                sprite.position = CGPoint(x: leftCornerCell, y: upperCornerCell)
//                cellLayer.addChild(sprite)
//                cellArray[row][col].sprite = sprite
//            }
//        }
//    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let numRows = 15
        let numCols = 10
        world = World(widthIn: numRows, heightIn: numCols)
        gridCoord = Array(count: numRows, repeatedValue: Array(count: numCols, repeatedValue: CGPointMake(0,0)))
        
        let bounds = UIScreen.mainScreen().bounds
        let widthScreen = bounds.size.width
        
        let gridWidth: CGFloat = widthScreen - margin*2
        cellSize = (gridWidth - CGFloat(numCols-1)*spaceBetwCells) * 1.0 / CGFloat(numCols)
        
        for row in 0...numRows-1 {
            for col in 0...numCols-1 {
                
                let leftCornerCell = margin + CGFloat(col) * (cellSize + spaceBetwCells)
                let upperCornerCell = upperSpace + CGFloat(row) * (cellSize + spaceBetwCells)
                gridCoord[row][col] = CGPointMake(leftCornerCell, -upperCornerCell)
                
                var cell = SKSpriteNode()
                if world.board[row][col].state == DEAD {
                    cell = SKSpriteNode(imageNamed: "dead")
                }
                else if world.board[row][col].state == P1 {
                    cell = SKSpriteNode(imageNamed: "player 1")
                }
                cell.size = CGSize(width: cellSize, height: cellSize)
                cell.position = CGPointMake(leftCornerCell, -upperCornerCell)
                cell.anchorPoint = CGPoint(x: 0, y: 1.0)
                
                world.board[row][col].sprite = cell

                addChild(cell)
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        var col = 0
        var row = 0
        for touch in touches {

            let location = touch.locationInNode(self)
            
            if (location.x - margin) / (cellSize + spaceBetwCells) < 0
            {
                col = -1
            }
            else {
                col = Int((location.x - margin) / (cellSize + spaceBetwCells))
            }
            
            if (abs(location.y) - upperSpace) / (cellSize + spaceBetwCells) < 0
            {
                row = -1
            }
            else {
                row = Int((abs(location.y) - upperSpace) / (cellSize + spaceBetwCells))
            }
                    
            if (col >= 0 && row >= 0 &&
                col < world.board[0].count && row < world.board.count)
            {
                let pos = world.board[row][col].sprite.position
                world.board[row][col].sprite.removeFromParent()

                var sprite = world.board[row][col].sprite
                sprite = SKSpriteNode(imageNamed: "player 1")
                sprite.size = CGSize(width: cellSize, height: cellSize)
                sprite.position = pos
                sprite.anchorPoint = CGPoint(x: 0, y: 1.0)
                world.board[row][col].sprite = sprite
                
                print("gridNode position \(sprite.position)")
                
//                if(world.board[row][col].state == P1) {
//                    world.board[row][col].state = DEAD
//                }
//                else {
                    world.board[row][col].state = P1
//                }

            }

        }
        world.printBoard()

        
    }
    
    
   
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
        let numRows = world.width
        let numCols = world.height
        
        for row in 0...numRows-1 {
            for col in 0...numCols-1 {

                let cell = world.board[row][col].sprite
                
                if cell.parent != nil {
                    cell.removeFromParent()

                }
                addChild(cell)
            }
        }
        world.nextGeneration()
    }
}
