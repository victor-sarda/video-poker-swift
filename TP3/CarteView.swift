//
//  CarteView.swift
//  TP3
//
//  Created by Victor Sarda on 16/11/2015.
//  Copyright © 2015 lpsil-dam. All rights reserved.
//

import Cocoa

class CarteView: NSView {

    var carte : Carte = Carte(valeur: Valeur.DEUX, couleur: Couleur.TREFLE)
        {
        didSet{
            
            setNeedsDisplayInRect(self.bounds)
        }
    }
    
    
    var estAffichee : Bool = false {
        didSet{
            
            setNeedsDisplayInRect(self.bounds)
        }
    }
    
    var estGelée: Bool = false {
        
        didSet{
            
            setNeedsDisplayInRect(self.bounds)
        }
    }
    
    // Afficher les cartes dans CarteView selon la carte
    override func drawRect(dirtyRect: NSRect) {
        
        super.drawRect(dirtyRect)
        if estAffichee
        {
            if(carte.couleur == Couleur.TREFLE)
            {
                for x in 2 ... 14
                {
                    if(carte.valeur.rawValue == x)
                    {
                        if(x != 14)
                        {
                            if let imageCarte = NSImage(named: "deck")
                            {
                                imageCarte.drawInRect(self.bounds, fromRect: NSRect(x: (x-1)*150, y: 0, width: 150, height: 200), operation: NSCompositingOperation.CompositeSourceOver, fraction: 1)
                            }
                        }
                        else
                        {
                            if let imageCarte = NSImage(named: "deck")
                            {
                                imageCarte.drawInRect(self.bounds, fromRect: NSRect(x: 0, y: 0, width: 150, height: 200), operation: NSCompositingOperation.CompositeSourceOver, fraction: 1)
                            }
                        }
                        
                    }
                }
                
            }
            if(carte.couleur == Couleur.PIQUE)
            {
                
                for x in 2 ... 14
                {
                    if(carte.valeur.rawValue == x)
                    {
                        if(x != 14)
                        {
                            if let imageCarte = NSImage(named: "deck")
                            {
                                imageCarte.drawInRect(self.bounds, fromRect: NSRect(x: (x-1)*150, y: 200, width: 150, height: 200), operation: NSCompositingOperation.CompositeSourceOver, fraction: 1)
                            }
                        }
                        else
                        {
                            if let imageCarte = NSImage(named: "deck")
                            {
                                imageCarte.drawInRect(self.bounds, fromRect: NSRect(x: 0, y: 200, width: 150, height: 200), operation: NSCompositingOperation.CompositeSourceOver, fraction: 1)
                            }
                        }
                        
                    }
                }
                
            }
            
            if(carte.couleur == Couleur.CARREAU)
            {
                
                for x in 2 ... 14
                {
                    if(carte.valeur.rawValue == x)
                    {
                        if(x != 14)
                        {
                            if let imageCarte = NSImage(named: "deck")
                            {
                                imageCarte.drawInRect(self.bounds, fromRect: NSRect(x: (x-1)*150, y: 400, width: 150, height: 200), operation: NSCompositingOperation.CompositeSourceOver, fraction: 1)
                            }
                        }
                        else
                        {
                            if let imageCarte = NSImage(named: "deck")
                            {
                                imageCarte.drawInRect(self.bounds, fromRect: NSRect(x: 0, y: 400, width: 150, height: 200), operation: NSCompositingOperation.CompositeSourceOver, fraction: 1)
                            }
                        }
                        
                    }
                }
            }
            if(carte.couleur == Couleur.COEUR)
            {
                
                for x in 2 ... 14
                {
                    if(carte.valeur.rawValue == x)
                    {
                        if(x != 14)
                        {
                            if let imageCarte = NSImage(named: "deck")
                            {
                                imageCarte.drawInRect(self.bounds, fromRect: NSRect(x: (x-1)*150, y: 600, width: 150, height: 200), operation: NSCompositingOperation.CompositeSourceOver, fraction: 1)
                            }
                        }
                        else
                        {
                            if let imageCarte = NSImage(named: "deck")
                            {
                                imageCarte.drawInRect(self.bounds, fromRect: NSRect(x: 0, y: 600, width: 150, height: 200), operation: NSCompositingOperation.CompositeSourceOver, fraction: 1)
                            }
                        }
                        
                    }
                }
            }
            
            
        }
        else
        {
            if let imageDos = NSImage(named: "dos")
            {
                imageDos.drawInRect(self.bounds, fromRect: NSRect(x: 0, y: 0, width: imageDos.size.width, height: imageDos.size.height), operation: NSCompositingOperation.CompositeSourceOver, fraction: 1)
            }
            
        }
        
    }
    
    override func mouseDown(theEvent: NSEvent) {
        
        if( estGelée == false ){
            // si la carte n'est pas gelée alors on peut la retourner
            if(estAffichee == false) // si elle n'est pas affichée
            {
                estAffichee = true //on l'affiche
            }
            else // sinon si elle est affiche
            {
                estAffichee = false // on la cache
            }
        }
        
    }
    
}
