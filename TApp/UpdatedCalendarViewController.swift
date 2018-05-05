//
//  UpdatedCalendarViewController.swift
//  TApp
//
//  Created by Liam Breen on 4/30/18.
//  Copyright © 2018 Liam Breen. All rights reserved.
//

import UIKit
import SnapKit
import CVCalendar

protocol DateDelegate {
    func setDate(date: Date, pickingSd: Bool)
}

class UpdatedCalendarViewController: UIViewController, CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .sunday
    }
    
    
    var menuView: CVCalendarMenuView!
    var calendarView: CVCalendarView!
    var selectButton: UIButton!
    var delegate: DateDelegate!
    var currentDate: Date! = Date.init()
    var pickingStartDate: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // CVCalendarMenuView initialization with frame
        self.menuView = CVCalendarMenuView(frame: CGRect(x: 0, y: 100, width: view.frame.size.width, height: 15))
        
        // CVCalendarView initialization with frame
        self.calendarView = CVCalendarView(frame: CGRect(x: 0,y: 120, width: view.frame.size.width, height: 450))
        
        // Appearance delegate [Unnecessary]
        self.calendarView.calendarAppearanceDelegate = self
        
        // Animator delegate [Unnecessary]
        self.calendarView.animatorDelegate = self
        
        // Menu delegate [Required]
        self.menuView.menuViewDelegate = self
        
        // Calendar delegate [Required]
        self.calendarView.calendarDelegate = self
        
        selectButton = UIButton()
        selectButton.setTitle("Select", for: .normal)
        selectButton.addTarget(self, action: #selector(selectButtonPressed), for: .touchUpInside)
        selectButton.setTitleColor(.red, for: .normal)
        selectButton.titleLabel?.font = UIFont.systemFont(ofSize: 48)
        
        view.addSubview(menuView)
        view.addSubview(calendarView)
        view.addSubview(selectButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        selectButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-48)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Commit frames' updates
        self.menuView.commitMenuViewUpdate()
        self.calendarView.commitCalendarViewUpdate()
    }
    
    @objc func selectButtonPressed() {
        delegate.setDate(date: currentDate, pickingSd: pickingStartDate)
        dismiss(animated: true, completion: nil)
    }
    
    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {
        currentDate = dayView.date.convertedDate()
    }
}
