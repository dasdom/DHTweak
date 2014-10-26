//
//  TweaksTableViewController.swift
//  TweaksDemo
//
//  Created by dasdom on 28.09.14.
//  Copyright (c) 2014 Dominik Hauser. All rights reserved.
//

import UIKit

public class CategoriesTableViewController: UITableViewController {

    var categories = [TweakCategory]()
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        let store = TweakStore.sharedTweakStore
        categories = store.allCategories()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Category")
        
        self.title = "Tweaks"
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "dismiss:")
    }

    // MARK: - Table view data source

    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Category", forIndexPath: indexPath) as UITableViewCell

        let category = categories[indexPath.row]
        cell.textLabel.text = category.name

        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let category = categories[indexPath.row]
        let colletionsTableViewController = CollectionsTableViewController(collections: category.allCollections())
        colletionsTableViewController.title = category.name
        navigationController?.pushViewController(colletionsTableViewController, animated: true)
    }
    
    func dismiss(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
