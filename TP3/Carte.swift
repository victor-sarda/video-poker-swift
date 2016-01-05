//
//  Carte.swift
//  TP2
//
//  Created by Victor Sarda on 03/11/2015.
//  Copyright © 2015 lpsil-dam. All rights reserved.
//

import Foundation


enum Valeur : Int
{
    case DEUX = 2, TROIS, QUATRE, CINQ, SIX, SEPT, HUIT, NEUF,
    DIX, VALET, DAME, ROI, AS
}

enum Couleur : Int
{
    case TREFLE = 0,CARREAU,COEUR,PIQUE
    func suite()-> String {
        switch self{
        case .TREFLE :
            return "♣️"
        case .CARREAU :
            return "♦️"
        case .COEUR :
            return  "♥️"
        case .PIQUE :
            return "♠️"
        }
    }
}


struct Carte {
    var valeur: Valeur
    var couleur: Couleur
    
    var description: String {
        
        switch valeur.rawValue{
        case (let x) where x < 10:
            return "\(x)" + couleur.suite()
        case 10:
            return "T" + couleur.suite()
        case 11:
            return "V" + couleur.suite()
        case 12:
            return "Q" + couleur.suite()
        case 13:
            return "K" + couleur.suite()
        case 14:
            return "A" + couleur.suite()
        default:
            return ""
        }
    }
    
    func isFigure()->Bool {
        if(valeur.rawValue > 10) {
            return true
        }
        else {
            return false
        }
    }
    
    
}
// OPERATEURS
func == (v1 : Carte, v2 : Carte) -> Bool {
    if(v1.valeur.rawValue == v2.valeur.rawValue) {
        return true
    } else {
        return false
    }
}
func != (v1 : Carte, v2 : Carte) -> Bool {
    if(v1.valeur.rawValue != v2.valeur.rawValue) {
        return true
    } else {
        return false
    }
}
func > (v1 : Carte, v2 : Carte) -> Bool {
    if(v1.valeur.rawValue > v2.valeur.rawValue) {
        return true
    } else {
        return false
    }
}
func < (v1 : Carte, v2 : Carte) -> Bool {
    if(v1.valeur.rawValue < v2.valeur.rawValue) {
        return true
    } else {
        return false
    }
}
func >= (v1 : Carte, v2 : Carte) -> Bool {
    if(v1.valeur.rawValue >= v2.valeur.rawValue) {
        return true
    } else {
        return false
    }
}
func <= (v1 : Carte, v2 : Carte) -> Bool {
    if(v1.valeur.rawValue <= v2.valeur.rawValue) {
        return true
    } else {
        return false
    }
}

func couleurInf(c1: Couleur, c2:Couleur) ->Bool{
    
    if (c1.rawValue != c2.rawValue){
        switch c1.rawValue{
        case 0:
            return true
        case 1:
            if(c2.suite() != "TREFLE"){
                return true
            } else {
                return false
            }
        case 2:
            if(c2.suite() == "PIQUE"){
                return true
            } else {
                return false
            }
        default:
            return false
            
        }
    } else {
        return false
    }
}

func couleurSuiv (c1: Couleur)-> Couleur {
    switch c1.rawValue{
    case 0:
        return Couleur(rawValue: 1)!
    case 1:
        return Couleur(rawValue: 2)!
    case 2:
        return Couleur(rawValue: 3)!
    default:
        return Couleur(rawValue: 0)!
    }
}


func ... (left:Carte , right:Carte) -> Array<Carte>{
    var res = Array<Carte>()
    if left.couleur == right.couleur{
        for i in left.valeur.rawValue...right.valeur.rawValue{
            
            res.append(Carte(valeur: Valeur(rawValue: i)!,couleur: left.couleur))
        }
    }
    
    if left.couleur.rawValue < right.couleur.rawValue{
        
        var j = left.valeur.rawValue
        for i in left.couleur.rawValue...right.couleur.rawValue {
            
            repeat{
                
                res.append(Carte(valeur: Valeur(rawValue: j)!,couleur: Couleur(rawValue: i )!))
                j++
                
                if i==right.couleur.rawValue && j>right.valeur.rawValue{ break}
            }while (j<=14) //tant qu'on a pas atteint le nombre max des cartes
            
            j = 2 // on reprend le numero de la premiere couleur : 2
            
        }
    }
    return res
}
