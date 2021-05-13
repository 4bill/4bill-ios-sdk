//
//  Binder.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 16.04.2021.
//

import Bindy

typealias ObservableData = Signal<Any>

fileprivate class BindListener {
    
    var signal: ObservableData
    var closure: ((_ value: Any?) -> ())?
    
    init(signal: ObservableData,
         closure: @escaping (_ value: Any?) -> ()) {
        self.signal = signal
        self.closure = closure
    }
    
    func subscribe(_ owner: AnyObject) {
        self.signal.bind(owner) { (value) in
            self.closure?(value)
        }
    }
       
    func unbind(_ owner: AnyObject) {
        self.signal.unbind(owner)
    }
    
}

fileprivate class BindHolder {
    
    var owner: AnyObject
    var listener: BindListener
    
    init(_ owner: AnyObject,
         listener: BindListener) {
        self.owner = owner
        self.listener = listener
    }
    
    func subscibe() {
        self.listener.subscribe(self.owner)
    }
    
    func unbind() {
        self.listener.unbind(self.owner)
    }
    
}

class Binder {
    
    private var bindings = [BindHolder]()
    
    open func bind<T>(_ owner: AnyObject,
                      signalModel: ObservableData,
                      closure: @escaping ((_ value: T?) -> ())) {
        let listener = BindListener(signal: signalModel) { (value) in
            closure(value as? T)
        }
        let holder = BindHolder(owner, listener: listener)
        bindings.append(holder)
        holder.subscibe()
    }
    
    open func unbindAll() {
        for binder in bindings {
            binder.unbind()
        }
        self.bindings.removeAll(keepingCapacity: true)
    }

}
