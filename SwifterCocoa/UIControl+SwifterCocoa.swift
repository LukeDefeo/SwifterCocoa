//
//  SwifterCocoa.h
//  SwifterCocoa
//
//  Created by Luke De Feo on 23/09/2015.
//  Copyright © 2015 SwifterCocoa. All rights reserved.
//


import Foundation
import UIKit
import ObjectiveC

var SwifterCocoaUIControlClosureDictKey = 0
typealias ClosureDict = [UInt : Set<ClosureWrapper>]

extension UIControl
{
	
	public func addCallBack(callback: Void -> Void, forControlEvents events: UIControlEvents)
	{
		
		var closureDict = objc_getAssociatedObject(self, &SwifterCocoaUIControlClosureDictKey) as? ClosureDict ?? ClosureDict()
		
		var closures = closureDict[events.rawValue] ?? Set<ClosureWrapper>()
		
		let wrapper = ClosureWrapper(callback:callback)
		addTarget(wrapper, action:ClosureWrapper.selector, forControlEvents: events)
		closures.insert(wrapper)
		
		closureDict[events.rawValue] = closures
		
		objc_setAssociatedObject(self, &SwifterCocoaUIControlClosureDictKey, closureDict, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		
	}
	
	public func removeAllCallBacksForControlEvents(events: UIControlEvents) {
		var closureDict = objc_getAssociatedObject(self, &SwifterCocoaUIControlClosureDictKey) as? ClosureDict ?? ClosureDict()
		let closures = closureDict[events.rawValue] ?? Set<ClosureWrapper>()
		for closure in closures {
			removeTarget(closure, action: ClosureWrapper.selector, forControlEvents: events);
		}
		closureDict[events.rawValue] = nil
		objc_setAssociatedObject(self, &SwifterCocoaUIControlClosureDictKey, closureDict, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		
		
	}
	
}