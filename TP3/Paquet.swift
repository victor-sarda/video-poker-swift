//
//  Paquet.swift
//  TP2
//
//  Created by Victor Sarda on 09/11/2015.
//  Copyright © 2015 lpsil-dam. All rights reserved.
//

import Foundation

class Paquet {
    
    var cartes:Array<Carte>
    
    var nbcartes:Int{
        return cartes.count
    }
    var isvide:Bool{
        
        get{
        
            if cartes.count == 0 {
                return true
            }
            else {return false}
        }
        set{
           return self.isvide = true
        }
    }
    
    var dessus:Carte?{
        return cartes.first
    }
    var description:String{
        var s:String = ""
        for c in cartes {
            s += c.description
            s += " "
        }
        return s
    }
    static var jeu52Cartes:Paquet{
        let p = Paquet()
        let c1 = Carte(valeur: Valeur.DEUX, couleur: Couleur.TREFLE)
        let c3 = Carte(valeur: Valeur.AS, couleur: Couleur.PIQUE)
        for x in c1...c3 {
            p.cartes.append(x)
        }
        return p
    }
    
    
    init (){
        cartes=[Carte]()
    }
    
    func ajouteDessus(c : Carte)-> Int {
        cartes.insert(c, atIndex:0)
        return nbcartes
    }
    
    func enleveDessus()-> Carte? {
        return cartes.removeFirst()
    }
    
    func ajouteDessous(p : Paquet)-> Int {
        for c in p.cartes {
            self.cartes.append(c)
        }
        return nbcartes
    }
    
    
    func melange()
    {
        for _ in 0..<10
        {
            cartes.sortInPlace { (_,_) in arc4random() < arc4random() }
        }
    }
    
        subscript (index : Int) -> Carte{
        return cartes[index]
    }
}









