#!/usr/bin/swift

/// MIT License
/// 
/// Copyright (c) 2017 hi@dnlggr.com
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.

import Foundation
import ApplicationServices

guard CommandLine.argc > 1 else {
	print("usage: defaultbrowser browser")
	exit(1)
}

let newDefault = CommandLine.arguments[1]
let schemes    = ["http" as CFString, "https" as CFString]

// Get the current default handler for the URL schemes
guard let oldDefault = LSCopyDefaultHandlerForURLScheme(schemes[0])?.takeRetainedValue() as? String else {
	print("Could not find default handler for \(schemes).")
	exit(1)
}

// Get the available handlers for the URL schemes
guard let availableHandlers = LSCopyAllHandlersForURLScheme(schemes[0])?.takeRetainedValue() as? [String] else {
	print("Could not find available handlers for \(schemes).")
	exit(1)
}

// Set the new default handler for the URL schemes
for handler in availableHandlers {
	if handler.components(separatedBy: ".").contains(where: { $0.lowercased() == newDefault.lowercased() }) {
		if handler == oldDefault {
			print("Default handler for \(schemes) is already \(handler).")
			exit(0)
		}
		for scheme in schemes {
			LSSetDefaultHandlerForURLScheme(scheme, handler as CFString)
		}
		print("Changing handler for \(schemes) from \(oldDefault) to \(handler).")
		exit(0)
	}
}

print("Could not set \(newDefault) as default handler for \(schemes).")
