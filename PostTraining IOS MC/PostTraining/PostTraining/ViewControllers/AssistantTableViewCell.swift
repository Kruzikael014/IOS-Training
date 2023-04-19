//
//  AssistantTableViewCell.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class AssistantTableViewCell: UITableViewCell {

    @IBOutlet weak var initialTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    var updateHandler = {}
    var deleteHandler = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func onClickDelete(_ sender: Any) {
        deleteHandler()
    }
    
    @IBAction func onClickUpdate(_ sender: Any) {
        updateHandler()
    }
}
