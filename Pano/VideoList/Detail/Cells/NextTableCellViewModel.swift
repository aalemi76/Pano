//
//  NextTableCellViewModel.swift
//  Pano
//
//  Created by AliReza on 2023-02-10.
//

import Foundation
import Combine

class NextTableCellViewModel: SharedCellViewModel {
    var didTapOnNextButton = PassthroughSubject<Bool, Never>()
}
