Extension { #name : #GRectangle }

{ #category : #'*Penfeld-Bloc' }
GRectangle >> asBlElement [
	^ (BlRectangle new extent: self extent) asElement
]
