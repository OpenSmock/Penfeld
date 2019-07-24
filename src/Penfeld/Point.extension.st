Extension { #name : #Point }

{ #category : #'*Penfeld' }
Point >> asSize [
	^ PenSize new
		x: self x;
		y: self y;
		yourself
]
