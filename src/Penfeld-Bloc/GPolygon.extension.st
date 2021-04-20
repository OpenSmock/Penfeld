Extension { #name : #GPolygon }

{ #category : #'*Penfeld-Bloc' }
GPolygon >> asBlElement [
	^ (BlPolygon new
		vertices: (self vertices collect: [ :gpoint | gpoint x @ gpoint y ]))
		asElement
]
