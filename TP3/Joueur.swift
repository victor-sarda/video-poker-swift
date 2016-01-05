//
//  Joueur.swift
//  TP2
//
//  Created by Victor Sarda on 09/11/2015.
//  Copyright © 2015 lpsil-dam. All rights reserved.
//

import Foundation

class Joueur : Paquet{
    
    var nom:String = ""
    var score:[String: Int] = ["": 0]
    
    override init() {
       
        score["Parties gagnées avec 0 as"]=0
        score["Parties gagnées avec 1 as"]=0
        score["Parties gagnées avec 2 as"]=0
        score["Parties gagnées avec 3 as"]=0
        score["Parties gagnées avec 4 as"]=0
        
    }

}
