Extension { #name : #GTriangle }

{ #category : #'*Penfeld-Bloc' }
GTriangle >> asBlElement [
	^ (BlPolygon new vertices: { 
		self v1 x @ self v1 y.
		self v2 x @ self v2 y.
		self v3 x @ self v3 y. }) asElement
]
