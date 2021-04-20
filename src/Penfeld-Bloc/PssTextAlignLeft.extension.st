Extension { #name : #PssTextAlignLeft }

{ #category : #'*Penfeld-Bloc' }
PssTextAlignLeft >> apply: aModel onBl: aTextElement [
	aTextElement constraintsDo: [ :c | c frame horizontal alignLeft ].
]
