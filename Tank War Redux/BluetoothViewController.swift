//
//  BluetoothViewController.swift
//  Tank War Redux
//
//  Created by Keith Davis on 11/2/17.
//  Copyright © 2017 Keith Davis. All rights reserved.
//

import UIKit
import GameKit
import MultipeerConnectivity

class BluetoothViewController: UIViewController,MCBrowserViewControllerDelegate,MCSessionDelegate,JSButtonDelegate, JSAnalogueStickDelegate{
    
    let serviceType = "tankGame"
    
    var browser : MCBrowserViewController!
    var assistant : MCAdvertiserAssistant!
    var session : MCSession!
    var peerID: MCPeerID!
    var player: BluetoothTankWarClient = BluetoothTankWarClient()
    
    @IBOutlet weak var analogueStick: JSAnalogueStick!
    @IBOutlet weak var fireButton: JSButton!
    
    @objc func buttonPressed(_ button:JSButton)
    {
    }
    
    @objc func buttonReleased(_ button:JSButton)
    {
        if(player.mytank.isLive){
            player.shells.append(Shell(tank: player.mytank ,client:player,attribute:true,id: 1/*Int32(arc4random())*/))
        }
        //player.shells.append(Shell(tank: player.myTank,client:player,attribute:true))
    }
    
    @objc func analogueStickDidChangeValue(_ analogueStick:JSAnalogueStick)
    {
        if(analogueStick.xValue==0 && analogueStick.yValue==0){
            player.mytank.isWalk=false
        }
        else if(absolute(analogueStick.xValue)>=absolute(analogueStick.yValue) && analogueStick.xValue>0){
            player.mytank.playerTankToward = .right
            player.mytank.isWalk=true
        }
        else if(absolute(analogueStick.xValue)>=absolute(analogueStick.yValue) && analogueStick.xValue<0){
            player.mytank.playerTankToward = .left
            player.mytank.isWalk=true
        }
        else if(absolute(analogueStick.xValue)<absolute(analogueStick.yValue) && analogueStick.yValue>0){
            player.mytank.playerTankToward = .up
            player.mytank.isWalk=true
        }
        else if(absolute(analogueStick.xValue)<absolute(analogueStick.yValue) && analogueStick.yValue<0){
            player.mytank.playerTankToward = .down
            player.mytank.isWalk=true
        }

        
    }
    
    @IBOutlet weak var gameStatus: UILabel!
    @IBOutlet weak var bluetoothTextView: UITextView!
    @IBOutlet weak var connect: UIButton!
    @IBOutlet weak var beginGame: UIButton!
    @IBAction func showBrowser(_ sender: UIButton) {
        self.present(self.browser, animated: true, completion: nil)
    }
    @IBAction func beginGame(_ sender: UIButton) {
        player.beginGame(self)
        do{
            try self.session.send("start".data(using: String.Encoding.utf16,
                allowLossyConversion: false)!, toPeers: self.session.connectedPeers,
                with: MCSessionSendDataMode.unreliable)
            print("send success")
        }
        catch let error as NSError {
            print("Error sending data: \(error.localizedDescription)")
        }

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //srand48(Int(time(nil)))
        //arc4random()
        
        beginGame.isEnabled = false
        analogueStick.delegate=self
        fireButton.titleLabel.text="F"
        fireButton.backgroundImage=UIImage(named: "button.png")!
        fireButton.backgroundImagePressed=UIImage(named: "button-pressed.png")!
        fireButton.delegate=self
        analogueStick.alpha=0.7
        fireButton.alpha=0.7
        analogueStick.isHidden=true
        fireButton.isHidden=true
        gameStatus.isHidden = true
        self.peerID = MCPeerID(displayName: UIDevice.current.name)
        self.session = MCSession(peer: peerID)
        self.session.delegate = self
        
        // create the browser viewcontroller with a unique service name
        self.browser = MCBrowserViewController(serviceType:serviceType,
            session:self.session)
        
        self.browser.delegate = self;
        
        self.assistant = MCAdvertiserAssistant(serviceType:serviceType,
            discoveryInfo:nil, session:self.session)
        
        // tell the assistant to start advertising our fabulous chat
        self.assistant.start()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateText(_ text : String) {
        var text = text
        // Appends some text to the chat view
        text = (text as NSString).substring(from: 8)
        self.bluetoothTextView.text=text
    }
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController)  {
            // Called when the browser view controller is dismissed (ie the Done
            // button was tapped)
        var str = ""
        
        // Networked peer "clients"
        for i in 0...self.session.connectedPeers.count-1{
            str = str + self.session.connectedPeers[i].displayName + ":\t" + "\(i+1) -> "
                + BlueTank.color["\(i+1)"]! + "\n"
        }
        // The "host" peer
        str = str + self.peerID.displayName+":\t" + "\(4) -> " + BlueTank.color["\(4)"]! + "\n"
        self.bluetoothTextView.text = str
        
        str="textview"+str
        
        do{
            try self.session.send(str.data(using: String.Encoding.utf16,
                allowLossyConversion: false)!, toPeers: self.session.connectedPeers,
                with: MCSessionSendDataMode.unreliable)
            print("send success")
        }
        catch let error as NSError {
            print("Error sending data: \(error.localizedDescription)")
        }
        
        self.setupTank(str)
        self.dismiss(animated: true, completion: nil)
        self.beginGame.isEnabled = true
        
    }
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController)  {
            // Called when the browser view controller is cancelled
            
            self.dismiss(animated: true, completion: nil)
    }
    
    func session(_ session: MCSession, didReceive data: Data,fromPeer peerID: MCPeerID)  {
            // Called when a peer sends an NSData to us
            
            // This needs to run on the main queue
            DispatchQueue.main.async {
                let msg = NSString(data: data, encoding: String.Encoding.utf16.rawValue)! as String
                if(msg.contains("textview")){
                    self.updateText(msg)
                    self.setupTank(msg)
                }
                else if(msg.contains("start")){
                    self.player.beginGame(self)
                }
                else if(msg.contains("location")){
                    self.player.updateEnemyLocation(msg)
                }
                else if(msg.contains("sendShell")){
                    self.player.updateShell(msg)
                }
                else if(msg.contains("explode")){
                    self.player.updateExplode(msg)
                }
            }
    }
    
    func setupTank(_ str:String){
        //if(str.containsString()
        var range = (str as NSString).range(of: self.peerID.displayName)
        var index = range.location+range.length+2
        var id = (str as NSString).substring( with: NSMakeRange(index, 1))
        self.player.identifier=id
        print(id)
        self.player.mytank = BlueTank(attribute: true, client: player, peerID: self.peerID, identifier: id)
        for i in 0 ... self.session.connectedPeers.count-1{
            range = (str as NSString).range(of: self.session.connectedPeers[i].displayName)
            index = range.location+range.length+2
            id = (str as NSString).substring( with: NSMakeRange(index, 1))
            print(id)
            self.player.enemyTank.append(BlueTank(attribute: true, client: player, peerID: self.session.connectedPeers[i], identifier: id))
        }
    }
    
    // The following methods do nothing, but the MCSessionDelegate protocol
    // requires that we implement them.
    func session(_ session: MCSession,
                 didStartReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID, with progress: Progress)  {
            
            // Called when a peer starts sending a file to us
    }
    
    func session(_ session: MCSession,
                 didFinishReceivingResourceWithName resourceName: String,
                 fromPeer peerID: MCPeerID,
                 at localURL: URL?, withError error: Error?)  {
            // Called when a file has finished transferring from another peer
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream,
                 withName streamName: String, fromPeer peerID: MCPeerID)  {
            // Called when a peer establishes a stream with us
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID,
        didChange state: MCSessionState)  {
            // Called when a connected peer changes state (for example, goes offline)
        let sessionCount = session.connectedPeers.count
        
        if (sessionCount == 4){
            self.dismiss(animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
