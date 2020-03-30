//
//  DashBoardViewModel.swift
//  List
//
//  Created by Praveenkumar Somu on 30/3/2563 BE.
//  Copyright © 2563 Praveenkumar Somu. All rights reserved.
//

import Foundation
import ReactiveSwift

class DashboardViewModel {
    enum State {
        case reverse
        case hundred
        case normal
    }
    var state: MutableProperty<State>
    var dataSource: [Int] = []
    var filteredDataSource: [Int] = []
    init() {
        state = MutableProperty(.normal)
        state.producer.startWithValues { (stateValue) in
            switch stateValue {
            case .hundred :
                self.limitDataSourceToHundered()
            case .reverse :
                self.getDataForReverse()
            case .normal :
                break
            }
        }
    }
    func fetch() -> SignalProducer<[Int], Error>{
        filteredDataSource = dataSource
        return SignalProducer<[Int], Error> { observer,lifetime  in
            observer.send(value: self.filteredDataSource)
            observer.sendCompleted()
        }
    }
    func getNumberOfRows() -> Int {
        return filteredDataSource.count
    }
    func getTextForRow(index: Int) -> String {
        return "\(filteredDataSource[index])"
    }
    func limitDataSourceToHundered() {
        filteredDataSource = dataSource.suffix(100)
    }
    func getDataForReverse() {
        filteredDataSource.reverse()
    }
    func getNormalData() {
        filteredDataSource = dataSource
    }
}
