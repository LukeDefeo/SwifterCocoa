//
//  NSTimer+SwifterCocoa.swift
//  SwiftyCocoa
//
//  Created by Luke De Feo on 23/09/2015.
//  Copyright © 2015 SwiftyCocoa. All rights reserved.
//

import Foundation


var SwifterCocoaNSTimerAssociatedObjectClass: UInt8 = 0
var SwifterCocoaNSTimerAssociatedObjectInit: UInt8 = 0
var SwifterCocoaNSTimerAssociatedObject3: UInt8 = 0


extension NSTimer
{
																						//extra brackets here to silence warning
	public class func scheduledTimerWithTimeInterval(interval: NSTimeInterval, closure: (() -> ()), repeats: Bool = true, userInfo: AnyObject? = nil) -> NSTimer {
		
		let closureWrapper = ClosureWrapper(callback: closure)
		objc_setAssociatedObject(self, &SwifterCocoaNSTimerAssociatedObjectClass, closureWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		return NSTimer.scheduledTimerWithTimeInterval(interval, target: closureWrapper, selector: ClosureWrapper.selector, userInfo: userInfo, repeats: repeats)
		
	}
	
	public convenience init(fireDate: NSDate, interval: NSTimeInterval,closure: () -> (), repeats: Bool = true, userInfo: AnyObject? = nil) {
		let closureWrapper = ClosureWrapper(callback: closure)
		self.init(fireDate:fireDate, interval: interval, target: closureWrapper, selector: ClosureWrapper.selector, userInfo: userInfo, repeats: repeats)
		
		objc_setAssociatedObject(self, &SwifterCocoaNSTimerAssociatedObjectInit, closureWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
	}

	//This hangs for some reason :/
//	public convenience init(interval: NSTimeInterval,closure: () -> (), repeats: Bool = true, userInfo: AnyObject? = nil) {
//		let closureWrapper = ClosureWrapper(callback: closure)
//		self.init(timeInterval:interval, target:closureWrapper, selector: ClosureWrapper.selector, userInfo: userInfo, repeats: repeats)
////		self.init(timeInterval: interval, target: closureWrapper, selector: ClosureWrapper.selector, userInfo: userInfo, repeats: repeats)
//		
//		objc_setAssociatedObject(self, &SwifterCocoaNSTimerAssociatedObject3, closureWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//	}
	
	

}