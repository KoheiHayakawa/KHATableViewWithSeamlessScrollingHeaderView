//
//  MusicViewController.swift
//  KHATableViewWithSeamlessScrollingHeaderViewDemo
//
//  Created by Kohei Hayakawa on 12/25/15.
//  Copyright © 2015 Kohei Hayakawa. All rights reserved.
//

import UIKit
import KHATableViewWithSeamlessScrollingHeaderView

class MusicViewController: KHATableViewWithSeamlessScrollingHeaderViewController {
    
    private let songs: NSArray = [
        "1. 20th Century Fox Fanfare",
        "2. Main Title/Rebel Blockade Runner",
        "3. Imperial Attack",
        "4. The Dune Sea of Tatooine/Jawa Sandcrawler",
        "5. The Moisture Farm",
        "6. The Hologram/Binary Sunset",
        "7. Landspeeder Search/Attack Of The Sand People",
        "8. Tales of a Jedi Knight/Learn About the Force",
        "9. Burning Homestead",
        "10. Mos Eisley Spaceport",
        "11. Cantina Band",
        "12. Cantina Band #2",
        "13. Archival Bonus Track: Binary Sunset (Alternate)",
        "1. Princess Leia's Theme",
        "2. The Millennium Falcon/Imperial Cruiser Pursuit",
        "3. Destruction of Alderaan",
        "4. The Death Star/The Stormtroopers",
        "5. Wookie Prisoner/Detention Block Ambush",
        "6. Shootout in the Cell Bay/Dianoga",
        "7. The Trash Compactor",
        "8. The Tractor Beam/Chasm Crossfire",
        "9. Ben Kenobi's Death/Tie Fighter Attack",
        "10. The Battle of Yavin",
        "11. The Throne Room/End Title"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Star Wars IV: A New Hope"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "addTapped")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func headerViewInView(view: KHATableViewWithSeamlessScrollingHeaderViewController) -> UIView {
        return UINib(nibName: "MusicHeaderView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songs.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("id", forIndexPath: indexPath)
        cell.textLabel?.text = "\(self.songs[indexPath.row])"
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        return cell
    }
}
