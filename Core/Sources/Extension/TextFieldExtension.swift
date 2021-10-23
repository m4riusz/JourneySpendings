//
//  TextFieldExtension.swift
//  Core
//
//  Created by Mariusz Sut on 22/10/2021.
//

import RxSwift
import RxCocoa

extension Reactive where Base: TextField {
    /// Reactive wrapper for `errorText` property.
    public var error: ControlProperty<String?> {
        return base.rx.controlProperty(editingEvents: .allEvents,
            getter: { textField in
                textField.errorText
            },
            setter: { textField, value in
                if textField.errorText != value {
                    textField.errorText = value
                }
            }
        )
    }
}
