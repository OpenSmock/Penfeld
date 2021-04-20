Extension { #name : #PssRadialGradientValue }

{ #category : #'*Penfeld-Bloc' }
PssRadialGradientValue >> asBlPaint [
	^ BlRadialGradientPaint new
		stops: self stops;
		yourself
]
