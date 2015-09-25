//
//  Base.swift
//  SwifterCocoa
//
//  Created by Luke De Feo on 25/09/2015.
//  Copyright © 2015 SwifterCocoa. All rights reserved.
//

import Foundation

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