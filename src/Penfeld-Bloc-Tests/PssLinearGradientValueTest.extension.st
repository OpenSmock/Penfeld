Extension { #name : #PssLinearGradientValueTest }

{ #category : #'*Penfeld-Bloc-Tests' }
PssLinearGradientValueTest >> testAsBlPaint [
	| pssValue blGradient stops |
	stops := { 0.0 -> Color red. 0.2 -> Color blue. 0.5 -> Color yellow. 1.0 -> Color black }.
	
	"To bottom"
	pssValue := PssLinearGradientValue new
		toBottom;
		stops: stops.
	blGradient := pssValue asBlPaint.
	self assert: blGradient class equals: BlLinearGradientPaint.
	self assert: blGradient start equals: 0@0.
	self assert: blGradient end equals: 0@1.
	
	"To Right"
	pssValue := PssLinearGradientValue new
		toRight;
		stops: stops.
	blGradient := pssValue asBlPaint.
	self assert: blGradient class equals: BlLinearGradientPaint.
	self assert: blGradient start equals: 0@0.
	self assert: blGradient end equals: 1@0.
]
