"
A PenWindowTest is a test class for testing the behavior of PenWindow
"
Class {
	#name : #PenWindowTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Tests-Components'
}

{ #category : #test }
PenWindowTest >> testGetView [
	| window view |
	view := PenView new key: #myView.
	
	window := PenWindow new 
		addView: (PenView new key: #view2);
		addView: PenView new;
		addView: view.
		
	self assert: (window getView: #myView) equals: view.
	
	window := PenWindow new 
		addView: (PenView new key: #view2);
		addView: PenView new.
		
	self assert: (window getView: #myView) equals: nil.
]
