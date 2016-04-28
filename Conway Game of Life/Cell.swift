//
//  Cell.swift
//  Conway Game of Life
//
//  Created by Shannon on 4/28/16.
//  Copyright © 2016 Elena Ariza. All rights reserved.
//

import Foundation



class Cell {
    // possible states of the cell
    let dead = 0;
    let P1 = 1; // cell is owned by player 1
    let P2 = 2; // cell is owned by player 2
    
    var x: Int;
    var y: Int;
    var state: Int;
    
    /*
    * x0: initial x location of cell
    * y0: initial y location of cell
    */
    init(x0: Int, y0: Int) {
        x = x0;
        y = y0;
        state = dead;
    }
    
}
