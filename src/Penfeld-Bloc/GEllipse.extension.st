Extension { #name : #GEllipse }

{ #category : #'*Penfeld-Bloc' }
GEllipse >> asBlElement [
	^ (BlEllipse extent: self extent) asElement
]
