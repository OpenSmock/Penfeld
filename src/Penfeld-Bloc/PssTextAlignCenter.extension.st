Extension { #name : #PssTextAlignCenter }

{ #category : #'*Penfeld-Bloc' }
PssTextAlignCenter >> apply: aModel onBl: aTextElement [
	aTextElement constraintsDo: [ :c | c frame horizontal alignCenter ].
	
]
