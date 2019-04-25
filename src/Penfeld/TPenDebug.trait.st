Trait {
	#name : #TPenDebug,
	#category : #'Penfeld-Utils'
}

{ #category : #'error handling' }
TPenDebug >> error: aMessage [
	Penfeld debugModeEnabled ifTrue: [ super error: aMessage ]
]

{ #category : #'error handling' }
TPenDebug >> warn: aMessage [
	Penfeld debugModeEnabled ifTrue: [ self traceCr: '[Penfeld] ', aMessage ]
]
