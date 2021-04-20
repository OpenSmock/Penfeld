Extension { #name : #GCircle }

{ #category : #'*Penfeld-Bloc' }
GCircle >> asBlElement [
	^ (BlCircle new extent: self extent) asElement
]
