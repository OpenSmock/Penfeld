Extension { #name : #PssTextAlignRight }

{ #category : #'*Penfeld-Bloc' }
PssTextAlignRight >> apply: aModel onBl: aTextElement [
	aTextElement constraintsDo: [ :c | c frame horizontal alignRight ].
]
