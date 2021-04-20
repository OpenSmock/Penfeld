Extension { #name : #OSWindow }

{ #category : #'*Penfeld-Bloc' }
OSWindow >> nativeWindowId [
	^ self platformSpecificHandle window asInteger
]
