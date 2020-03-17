Extension { #name : #PssPositionAbsolute }

{ #category : #'*Penfeld-Bloc' }
PssPositionAbsolute >> apply: aModel onBl: anElement [
	self flag: 'Not an absolute position'.
	self flag: 'Absolute position can be specified with bottom and right'.
	anElement position: (aModel top @ aModel left)
]
