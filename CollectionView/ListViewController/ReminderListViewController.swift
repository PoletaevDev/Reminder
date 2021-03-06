//
//  ViewController.swift
//  CollectionView
//
//  Created by Александр Полетаев on 10.05.2022.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    
    var dataSource: DataSourse!
    var reminders: [Reminder] = Reminder.sampleData

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
            
        dataSource = DataSourse(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(reminders.map{ $0.id })
        dataSource.apply(snapshot)
        
        updateSnapshot()
        collectionView.dataSource = dataSource
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = reminders[indexPath.item].id
        showDetail(for: id)
        return false
    }
    
    func showDetail(for id: Reminder.ID) {
          let reminder = reminder(for: id)
        let vc = ReminderViewController(reminder: reminder)
        navigationController?.pushViewController(vc, animated: true)
      }


    private func listLayout() -> UICollectionViewCompositionalLayout{
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
        
    }
    
    func reminder(for id: Reminder.ID) -> Reminder {
            let index = reminders.indexOfReminder(with: id)
            return reminders[index]
        }
        
        func update(_ reminder: Reminder, with id: Reminder.ID) {
            let index = reminders.indexOfReminder(with: id)
            reminders[index] = reminder
        }
}

