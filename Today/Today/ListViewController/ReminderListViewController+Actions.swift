//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by 문상우 on 2023/06/20.
//

import UIKit

extension ReminderListViewController {
    
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
    
}
