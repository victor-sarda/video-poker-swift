//
//  AppDelegate.swift
//  TP3
//
//  Created by Victor Sarda on 16/11/2015.
//  Copyright © 2015 lpsil-dam. All rights reserved.
//

import Cocoa

// Librairie pour jouer un son
import AVFoundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    @IBOutlet weak var valCaisse: NSTextField!
    @IBOutlet weak var valPari: NSTextField!
    
    // Création des cartes
    @IBOutlet weak var carte1: CarteView!
    @IBOutlet weak var carte2: CarteView!
    @IBOutlet weak var carte3: CarteView!
    @IBOutlet weak var carte4: CarteView!
    @IBOutlet weak var carte5: CarteView!

    @IBOutlet weak var btnAjoute: NSButton!
    @IBOutlet weak var btnEnleve: NSButton!
    @IBOutlet weak var btnJouer: NSButton!
    @IBOutlet weak var btnRejouer: NSButton!

    @IBOutlet weak var lblErreur: NSTextField!
    @IBOutlet weak var lblEtape: NSTextField!
    @IBOutlet weak var lblScore: NSTextField!
    @IBOutlet weak var lblNbParties: NSTextField!
    
    // Ouvrir une page web des règles
    @IBAction func afficherRègles(sender: NSMenuItem) {
        
        let url = NSURL(string: "http://www.casinos-francaisonline.com/regles-video-poker.html")!
        NSWorkspace.sharedWorkspace().openURL(url)
    }
    
    // Variables globales
    var nCaisse: Int = 100
    var nPari: Int = 0
    
    var p : Paquet = Paquet()
    var tapis : Paquet = Paquet()
    var pTemp : Paquet = Paquet()
    
    var tabValeur = Array<Int>()
    var tabCouleur = Array<Int>()
    
    var x: Int = 0
    var y: Int = 0
    
    var afficheEtape = "Manche terminée"
    var multiplicateurScore = 0
    var fin = false
    var nbParties = 0
    
    // Nouvelle partie (menu)
    @IBAction func nouvellePartie(sender: NSMenuItem) {
        
        valCaisse.stringValue = "100"
        valPari.stringValue = "0"
        nCaisse = 100
        nPari = 0
        nbParties = 0
        lblNbParties.stringValue = "Nombre de parties jouées : 0"
        p.cartes.removeAll()
        tapis.cartes.removeAll()
        p = Paquet.jeu52Cartes
        cacherCartes()
        gel()
        jouerSonCartes()
        lblScore.stringValue = ""
        lblErreur.hidden = true
        lblEtape.stringValue = "Début du jeu"
        btnRejouer.hidden = true
        btnJouer.enabled = true
        btnAjoute.enabled = true
        btnEnleve.enabled = true
        fin = false
        
        
    }
    
    // Bouton de triche (Choix des cartes)
    @IBAction func btnTriche(sender: NSButton) {
    
        lblScore.stringValue = ""
        
        let c1 : Carte = Carte(valeur:Valeur.AS, couleur: Couleur.COEUR)
        let c2 : Carte = Carte(valeur:Valeur.DIX, couleur: Couleur.COEUR)
        let c3 : Carte = Carte(valeur:Valeur.VALET, couleur: Couleur.COEUR)
        let c4 : Carte = Carte(valeur:Valeur.ROI, couleur: Couleur.COEUR)
        let c5 : Carte = Carte(valeur:Valeur.DAME, couleur: Couleur.COEUR)

        carte1.carte.valeur = c1.valeur
        carte1.carte.couleur = c1.couleur
        
        carte2.carte.valeur = c2.valeur
        carte2.carte.couleur = c2.couleur
        
        carte3.carte.valeur = c3.valeur
        carte3.carte.couleur = c3.couleur
        
        carte4.carte.valeur = c4.valeur
        carte4.carte.couleur = c4.couleur
        
        carte5.carte.valeur = c5.valeur
        carte5.carte.couleur = c5.couleur
        
        if nPari == 0{
            
            lblErreur.hidden = false
            lblErreur.stringValue = "Attention la mise ne peut pas être à 0"
        }
        else{
            
                tapis.ajouteDessus(c1)
                tapis.ajouteDessus(c2)
                tapis.ajouteDessus(c3)
                tapis.ajouteDessus(c4)
                tapis.ajouteDessus(c5)
            
                gel()
            
                btnJouer.enabled = false
                btnRejouer.hidden = false
                
                print("Tapis fin")
                print(tapis.description)
                
                tabValeur = TestTapis().triParValeur(tapis)
                tabCouleur = TestTapis().triParCouleur(tapis)
            
                jouerSonCartes()
                calculGain()
            
                tapis.cartes.removeAll()
                
                lblEtape.stringValue = afficheEtape
                
                afficherCartes()
            
                lblEtape.stringValue = afficheEtape
            
            }
        
    }
    
    @IBAction func ajoute(sender: NSButton) {
        
        
        // Récupère valeur champs de texte
        
        nPari = Int(valPari.stringValue)!
        nCaisse = Int(valCaisse.stringValue)!
        
        // Si la caisse est supérieure à 0 
        
        if nCaisse > 0 {
            
            // On décrémente la caisse et on incrémente le pari
            
            nCaisse--
            nPari++
        }
        
        // On met à jour l'affichage
        valCaisse.stringValue = String(nCaisse)
        valPari.stringValue = String(nPari)
        
        
    }
    
    @IBAction func enleve(sender: NSButton) {
        
        
        // Récupère valeur champs de texte
        
        nPari = Int(valPari.stringValue)!
        nCaisse = Int(valCaisse.stringValue)!
        
        // Si la le pari est supérieure à 0
        
        if nPari > 0 {
            
            // On incrémente la caisse et on décrémente le pari
            
            nCaisse++
            nPari--
        }
        
        // On met à jour l'affichage
        valCaisse.stringValue = String(nCaisse)
        valPari.stringValue = String(nPari)

    }
    
    // Bouton Jouer
    @IBAction func jouer(sender: NSButton) {
        
        lblScore.stringValue = ""
        
        // Vérifie si on mise
        if nPari == 0{
            
            lblErreur.hidden = false
            lblErreur.stringValue = "Attention la mise ne peut pas être à 0"
        }
        // Si on mise :
        else{
            
            lblErreur.hidden = true
            lblEtape.stringValue = "Choisissez les cartes que vous voulez changer"
            
            // Première étape
            if fin == false{
                
                melageEtDistribue()
                
                btnEnleve.enabled = false
                btnAjoute.enabled = false
                
                afficherCartes()
                degel()
                
                fin = true
            }
            // Change les cartes choisies
            else{
                
                if carte1.estAffichee == false{
                    
                    pTemp.ajouteDessus(carte1.carte)
                    tapis.cartes.removeAtIndex(0)
                    carte1.carte = p.enleveDessus()!
                    tapis.cartes.insert(carte1.carte, atIndex: 0)
                    carte1.estAffichee = true
                }
                
                if carte2.estAffichee == false{
                    
                    pTemp.ajouteDessus(carte2.carte)
                    tapis.cartes.removeAtIndex(1)
                    carte2.carte = p.enleveDessus()!
                    tapis.cartes.insert(carte2.carte, atIndex: 1)
                    carte2.estAffichee = true
                }
                if carte3.estAffichee == false{
                    
                    pTemp.ajouteDessus(carte3.carte)
                    tapis.cartes.removeAtIndex(2)
                    carte3.carte = p.enleveDessus()!
                    tapis.cartes.insert(carte3.carte, atIndex: 2)
                    carte3.estAffichee = true
                }
                if carte4.estAffichee == false{
                    
                    pTemp.ajouteDessus(carte4.carte)
                    tapis.cartes.removeAtIndex(3)
                    carte4.carte = p.enleveDessus()!
                    tapis.cartes.insert(carte4.carte, atIndex: 3)
                    carte4.estAffichee = true
                }
                if carte5.estAffichee == false{
                    
                    pTemp.ajouteDessus(carte5.carte)
                    tapis.cartes.removeAtIndex(4)
                    carte5.carte = p.enleveDessus()!
                    tapis.cartes.insert(carte5.carte, atIndex: 4)
                    carte5.estAffichee = true
                }
                
                if pTemp.isvide == false{
                    
                    p.ajouteDessous(pTemp)
                }
                
                // Bloque les cartes
                gel()
                
                btnJouer.enabled = false
                btnRejouer.hidden = false
                
                print("Tapis fin")
                print(tapis.description)

                tabValeur = TestTapis().triParValeur(tapis)
                tabCouleur = TestTapis().triParCouleur(tapis)
                
                // Calcule les gains
                calculGain()
                
                p.ajouteDessous(tapis)
                tapis.cartes.removeAll()
                
                print("Paquet fin")
                print(p.description)
                
                afficherCartes()
                

                lblEtape.stringValue = afficheEtape
            }
            
        }
        
    }
    
    // Rejouer
    @IBAction func btnRejouer(sender: NSButton) {
        
        lblScore.stringValue = ""
        
        fin = false
        
        nPari = 0
        valPari.stringValue = String(0)
        
        lblEtape.stringValue = "Début du jeu"
        
        btnJouer.enabled = true
        btnRejouer.hidden = true
        btnAjoute.enabled = true
        btnEnleve.enabled = true
        
        cacherCartes()
        nbParties++
        pTemp.cartes.removeAll()
        lblNbParties.stringValue = "Nombre de parties jouées : \(String(nbParties))"
        
        
        
        
        
    }
    
    // Calculer le gain en testant les valeurs ou les couleurs du tapis
    func calculGain(){
        
        if TestTapis().isPaire(tabValeur) {
            
            lblScore.stringValue = "Vous avez une Paire"
            print("Paire")
            multiplicateurScore = 1
        }
        if TestTapis().isDoublePaire(tabValeur){
            
            lblScore.stringValue = "Vous avez une Double paire"
            print("Double Paire")
            multiplicateurScore = 2
        }
        
        if TestTapis().isBrelan(tabValeur){
            
            lblScore.stringValue = "Vous avez un Brelan"
            multiplicateurScore = 3
            print("Brelan")
        }
        if TestTapis().isQuinte(tabValeur){
            
            lblScore.stringValue = "Vous avez une Quinte"
            multiplicateurScore = 4
            print("Quinte")
        }
        if TestTapis().isFlush(tabCouleur){
            
            lblScore.stringValue = "Vous avez un Flush"
            print("Flush")
            multiplicateurScore = 6
        }
        if TestTapis().isFull(tabValeur){
            
            lblScore.stringValue = "Vous avez une Full"
            print("Full")
            multiplicateurScore = 9
        }
        if TestTapis().isCarre(tabValeur){
            
            lblScore.stringValue = "Vous avez un Carré"
            print("Carré")
            multiplicateurScore = 20
        }
        if TestTapis().isQuinteFlush(tabValeur, tabCoul: tabCouleur){
            
            lblScore.stringValue = "Vous avez une Quinte Flush"
            print("Quinte Flush")
            multiplicateurScore = 50
        }
        if TestTapis().isQuinteFlushRoyale(tabValeur, tabCoul: tabCouleur){
            
            lblScore.stringValue = "Vous avez une Quinte Flush Royale"
            print("Quinte Flush Royale")
            multiplicateurScore = 250
        }
        
        
        // Calculue le gain selon le pari
        switch (multiplicateurScore){
        case 1 :
            valCaisse.stringValue = String(nCaisse + nPari * 1)
        case 2 :
            valCaisse.stringValue = String(nCaisse + nPari * 2)
        case 3 :
            valCaisse.stringValue = String(nCaisse + nPari * 3)
        case 4 :
            valCaisse.stringValue = String(nCaisse + nPari * 4)
        case 6 :
            valCaisse.stringValue = String(nCaisse + nPari * 6)
        case 9 :
            valCaisse.stringValue = String(nCaisse + nPari * 9)
        case 20 :
            valCaisse.stringValue = String(nCaisse + nPari * 20)
        case 50 :
            valCaisse.stringValue = String(nCaisse + nPari * 50)
        case 250 :
            valCaisse.stringValue = String(nCaisse + nPari * 250)
            
        default :
            valCaisse.stringValue = valCaisse.stringValue
            
        }

    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        
        // Création du paquet
        p = Paquet.jeu52Cartes
        
        // Init caisse et pari
        valCaisse.stringValue = String(nCaisse)
        valPari.stringValue = String(nPari)
        
        // Bloque les cartes
        gel()
        
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    func melageEtDistribue() {
        
        p.melange()
        jouerSonCartes()
        
        print("Paquet mélangé : \n")
        print(p.description)
        
        carte1.carte = p.enleveDessus()!
        carte2.carte = p.enleveDessus()!
        carte3.carte = p.enleveDessus()!
        carte4.carte = p.enleveDessus()!
        carte5.carte = p.enleveDessus()!
        
        tapis.ajouteDessus(carte5.carte)
        tapis.ajouteDessus(carte4.carte)
        tapis.ajouteDessus(carte3.carte)
        tapis.ajouteDessus(carte2.carte)
        tapis.ajouteDessus(carte1.carte)
        
        TestTapis().triParValeur(tapis)
        
        gel()
    }

    // Fermer l'application en cliquant sur le bouton close
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }

    
    func afficherCartes(){
        
        carte1.estAffichee = true
        carte2.estAffichee = true
        carte3.estAffichee = true
        carte4.estAffichee = true
        carte5.estAffichee = true
        
    }
    
    func cacherCartes(){
        
        carte1.estAffichee = false
        carte2.estAffichee = false
        carte3.estAffichee = false
        carte4.estAffichee = false
        carte5.estAffichee = false
    }
    
    func gel(){
        
        carte1.estGelée = true
        carte2.estGelée = true
        carte3.estGelée = true
        carte4.estGelée = true
        carte5.estGelée = true
    }
    
    func degel(){
        
        carte1.estGelée = false
        carte2.estGelée = false
        carte3.estGelée = false
        carte4.estGelée = false
        carte5.estGelée = false
    }
    
    func jouerSonCartes(){
        
        // URL du son "shuffling-cards.mp3"
        if let soundURL = NSBundle.mainBundle().URLForResource("shuffling-cards", withExtension: "mp3") {
            var cardSound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL, &cardSound)
            // Play
            AudioServicesPlaySystemSound(cardSound);
        }
        
    }
    
}

