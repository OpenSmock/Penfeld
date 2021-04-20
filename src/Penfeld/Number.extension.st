Extension { #name : #Number }

{ #category : #'*Penfeld' }
Number >> , aNumber [
	self flag:'PLA : Patch to re install Geometry Number coma method overrided by Bloc'.
	^ GPoint x: self y: aNumber
]
