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

public class ClosureWrapper : NSObject
{
	
	static let selector = Selector("invoke")
	let callback : Void -> Void
	init(callback : Void -> Void) {
		self.callback = callback
	}
	
	public func invoke()
	{
		callback()
	}
	
}

var AssociatedObjectHandle: UInt8 = 0

extension UIControl
{
	public func addCallBack(callback: Void -> Void, forControlEvents events: UIControlEvents)
	{
		let wrapper = ClosureWrapper(callback:callback)
		addTarget(wrapper, action:"invoke", forControlEvents: events)
		// as @newacct said in comment, we need to retain wrapper object
		// this only support 1 target, you can use array to support multiple target objects
		objc_setAssociatedObject(self, &AssociatedObjectHandle, wrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
	}
}