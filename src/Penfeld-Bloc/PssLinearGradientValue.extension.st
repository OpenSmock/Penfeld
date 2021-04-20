Extension { #name : #PssLinearGradientValue }

{ #category : #'*Penfeld-Bloc' }
PssLinearGradientValue >> asBlPaint [
	^ (BlLinearGradientPaint direction: self direction)
		stops: self stops;
		yourself
]
