//
//  InitalTableViewController.swift
//  SwiftExample
//
//  Created by P D Leonard on 7/22/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit

let cellIdentifier = "cellIdentifier"

class InitalTableViewController: UITableViewController {
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ServerRequest.shared.testServerRequest()

//        //test logging in
//        ServerRequest.shared.loginWithEmail(email: "test1", password: "test", success: { (user) -> Void in
//            print(user.toDictionary())
//            },failure: { (errorMessage) -> Void in
//                print(errorMessage)
//        })
//        
//        ServerRequest.shared.signUpWithEmail(email: "test9", password: "test9", username: "test9", success: { (json) -> Void in
//            print(json)
//        },failure: { (errorMessage) -> Void in
//            print(errorMessage)
//        })
        
//        ServerRequest.shared.sendNewQuestionResponse(user_id: 1, question: "What is your name?", response: "Anthony", response_time: 4, errors: 2, pauses: 2, success: { (json) -> Void in
//            print(json)
//        },failure: { (errorMessage) -> Void in
//            print(errorMessage)
//        })
        

        self.title = "ACE The Brain"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (section) {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Talk to Steve Jobs"
                break
            case 1:
                cell.textLabel?.text = "Group Conversation"
                break
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Settings"
                break
            default:
                break
            }
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {

        case 1:
            return "Options"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        switch section {
//        case 0:
//            return "Copyright © 2015\nJesse Squires\nMIT License"
//        case 1:
//            return "Thanks to all the contributers and MacMeDan for this swift example."
//        default:
//            return nil
//        }
        return nil
    }
    
    //Mark: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let chatView = ChatViewController()
                //chatView.messages = makeNormalConversation()
                let chatNavigationController = UINavigationController(rootViewController: chatView)
                present(chatNavigationController, animated: true, completion: nil)
            case 1:
                let chatView = ChatViewController()
                //chatView.messages = makeGroupConversation()
                let chatNavigationController = UINavigationController(rootViewController: chatView)
                present(chatNavigationController, animated: true, completion: nil)
            default:
                return
            }
        case 1:
            switch indexPath.row {
            case 0:
                self.present(UINavigationController(rootViewController: SettingsTableViewController()), animated: true, completion: nil)
            default:
                return
            }
        default:
            return
        }
    }
    
    
    
}
