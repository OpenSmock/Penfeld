Extension { #name : #BlLinearGradientPaint }

{ #category : #'*Penfeld-Bloc-Tests' }
BlLinearGradientPaint >> = aLinearGradient [

	self end = aLinearGradient end ifFalse: [ ^ false ].
	self start = aLinearGradient start ifFalse: [ ^ false ].
	1 to: self stops size do: [ :i | 
		(self stops at: i) = (aLinearGradient stops at: i)
			ifFalse: [ ^false ]
	].
	^ true
]
