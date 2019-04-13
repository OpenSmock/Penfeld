Class {
	#name : #PenDisplayComponent,
	#superclass : #PenComponent,
	#instVars : [
		'dresser',
		'engine',
		'dressersMap',
		'stylesheet',
		'styleClasses',
		'enabled',
		'visible',
		'built',
		'parent',
		'position',
		'width',
		'height',
		'transformation',
		'alignment',
		'pseudoClasses',
		'engineElement',
		'eventBindings'
	],
	#category : #'Penfeld-Core'
}

{ #category : #events }
PenDisplayComponent >> actionEvent [
	self eventBindings do: [ :eventBinding |
		(eventBinding symbolMatches: PenEventSymbol action)
			ifTrue: [ eventBinding executeCallback ]].
]

{ #category : #accessing }
PenDisplayComponent >> activatePseudoClass: aSymbol [
	self pseudoClasses add: aSymbol -> nil.
	self refresh
]

{ #category : #accessing }
PenDisplayComponent >> activatePseudoClass: aSymbol value: anArg [
	self pseudoClasses add: aSymbol -> anArg.
	self refresh
]

{ #category : #private }
PenDisplayComponent >> addCallback: aBlock for: anEventSymbol [
	| binding |
	self deprecated: ''.
	binding := PenEventBinding for: anEventSymbol do: aBlock.
	eventBindings add: binding.
	^ binding
]

{ #category : #private }
PenDisplayComponent >> addCallback: aBlock forAll: anEventSymbolList [
	| binding |
	self deprecated: ''.
	binding := PenEventBinding forAll: anEventSymbolList do: aBlock.
	eventBindings add: binding.
	^ binding
]

{ #category : #accessing }
PenDisplayComponent >> addStyleClass: aSymbol [
	self styleClasses add: aSymbol.
	self refresh
]

{ #category : #building }
PenDisplayComponent >> build [ 
	| eventStrategy |
	self isBuilt ifTrue: [ ^ self ].
	
	self stylesheet ifNil: [ self stylesheet: self chooseStylesheet ].
	
	self dresser ifNil: [ self dresser: (self chooseDresserFor: self) new ].
	self dresser initEngineElement.
	self dresser dress.
	
	eventStrategy := self dresser eventStrategy.
	eventBindings do: [ :eventBinding | (eventStrategy tryToBind: eventBinding)
		ifFalse: [ self warn: 'Can not bind ', eventBinding symbol ] ].

	built := true.
]

{ #category : #building }
PenDisplayComponent >> build: anIndex [
	self activatePseudoClass: #nthChild value: anIndex.
	anIndex even 
		ifTrue: [ self activatePseudoClass: #nthChild value: #even ]
		ifFalse: [ self activatePseudoClass: #nthChild value: #odd ].
	self build.
]

{ #category : #building }
PenDisplayComponent >> chooseDresserFor: aModel [
"Choose a dresser, following next steps:
TBD"
	
	self parent
		ifNotNil:
		[ 
			self parent dresser 
				ifNil: [ ^ self parent chooseDresserFor: aModel ] 
				ifNotNil: [ ^ self parent dresser dressersMap dresserFor: aModel class ]
		]
		ifNil: 
		[ 
			self engine ifNil: [ self engine: PenEngine default ].
			^ self engine dressersMap dresserFor: aModel class.
		]
	
	
]

{ #category : #building }
PenDisplayComponent >> chooseStylesheet [
	self parent
		ifNotNil:
		[ 
			self parent stylesheet 
				ifNil: [ ^ self parent chooseStylesheet ] 
				ifNotNil: [ ^ self parent stylesheet ]
		]
		ifNil: [ 	^ PenStylesheet current ]
	
	
]

{ #category : #accessing }
PenDisplayComponent >> clearAllPseudoClass [
	self pseudoClasses removeAll.
	self refresh
]

{ #category : #events }
PenDisplayComponent >> clickEvent: anEvent [
	self eventBindings do: [ :eventBinding |
		(eventBinding symbolMatches: PenEventSymbol click)
			ifTrue: [ eventBinding executeCallback: anEvent ]].
]

{ #category : #accessing }
PenDisplayComponent >> deactivatePseudoClass: aSymbol [
	pseudoClasses := pseudoClasses reject: [ :association |
		association key = aSymbol ].
	self refresh
]

{ #category : #accessing }
PenDisplayComponent >> disable [
	self enabled: false
]

{ #category : #accessing }
PenDisplayComponent >> dresser [
	^ dresser
]

{ #category : #accessing }
PenDisplayComponent >> dresser: aDresser [
	dresser := aDresser.
	aDresser component: self.
]

{ #category : #accessing }
PenDisplayComponent >> dressersMap [
	^ dressersMap
]

{ #category : #accessing }
PenDisplayComponent >> dressersMap: anObject [
	dressersMap := anObject
]

{ #category : #accessing }
PenDisplayComponent >> enable [
	self enabled: true
]

{ #category : #accessing }
PenDisplayComponent >> enabled: aBoolean [
	enabled = aBoolean ifTrue: [ ^ self ].
	
	enabled := aBoolean.
	enabled 
		ifTrue: [ 
			self deactivatePseudoClass: #disabled.
			self activatePseudoClass: #enabled. ]
		ifFalse: [ 
			self deactivatePseudoClass: #enabled.
			self activatePseudoClass: #disabled ]
]

{ #category : #accessing }
PenDisplayComponent >> engine [
	^ engine
]

{ #category : #accessing }
PenDisplayComponent >> engine: anObject [
	engine := anObject
]

{ #category : #accessing }
PenDisplayComponent >> engineElement [
	^ engineElement
]

{ #category : #accessing }
PenDisplayComponent >> engineElement: anObject [
	engineElement := anObject
]

{ #category : #'private-accessing' }
PenDisplayComponent >> eventBindings [
	^ eventBindings
]

{ #category : #accessing }
PenDisplayComponent >> height [
	^ height
]

{ #category : #accessing }
PenDisplayComponent >> height: aLength [
	height := aLength asLength
]

{ #category : #initialization }
PenDisplayComponent >> initialize [
	super initialize.
	enabled := true.
	visible := true.
	built := false.
	styleClasses := OrderedCollection new.
	pseudoClasses := OrderedCollection new.
	eventBindings := OrderedCollection new.
]

{ #category : #testing }
PenDisplayComponent >> isBuilt [
	^ built
]

{ #category : #testing }
PenDisplayComponent >> isContainer [
	^ false
]

{ #category : #testing }
PenDisplayComponent >> isDisabled [
	^ enabled not
]

{ #category : #testing }
PenDisplayComponent >> isEnabled [
	^ enabled
]

{ #category : #testing }
PenDisplayComponent >> isVisible [
	^ visible
]

{ #category : #accessing }
PenDisplayComponent >> matchedRules [
	^ self stylesheet matchingRulesFor: self.
]

{ #category : #events }
PenDisplayComponent >> mouseDownEvent: anEvent [
	self eventBindings do: [ :eventBinding |
		(eventBinding symbolMatches: PenEventSymbol mouseDown)
			ifTrue: [ eventBinding executeCallback: anEvent ]].
]

{ #category : #'api - events' }
PenDisplayComponent >> on: aListOfSymbols do: aBlock [
	self deprecated: ''.
	self addCallback: aBlock forAll: aListOfSymbols 
]

{ #category : #'api - events' }
PenDisplayComponent >> onEvent: aSymbol do: aBlock [
	| binding |
	binding := PenEventBinding for: aSymbol do: aBlock.
	binding source: self.
	eventBindings add: binding.
]

{ #category : #'api - events' }
PenDisplayComponent >> onEvent: aSymbol perform: aFunction on: aPerformer [
	| binding |
	binding := PenEventBinding for: aSymbol perform: aFunction on: aPerformer.
	binding source: self.
	eventBindings add: binding.
]

{ #category : #'api - events' }
PenDisplayComponent >> onEvents: aListOfSymbols do: aBlock [
	| binding |
	binding := PenEventBinding forAll: aListOfSymbols do: aBlock.
	binding source: self.
	eventBindings add: binding.
]

{ #category : #'api - events' }
PenDisplayComponent >> onEvents: aListOfSymbols perform: aFunction on: aPerformer [
	| binding |
	binding := PenEventBinding forAll: aListOfSymbols perform: aFunction on: aPerformer.
	binding source: self.
	eventBindings add: binding.
]

{ #category : #opening }
PenDisplayComponent >> openInInternalWindow [
	self deprecated: 'use openInWorld instead'. 
	self openInWorld.
]

{ #category : #opening }
PenDisplayComponent >> openInWindow [
	^ self notYetImplemented 
]

{ #category : #opening }
PenDisplayComponent >> openInWorld [
	| view |
	self isBuilt ifFalse: [ self build ].
	view := PenView with: self.
	view openInWorld
]

{ #category : #accessing }
PenDisplayComponent >> parent [
	^ parent
]

{ #category : #accessing }
PenDisplayComponent >> parent: aModel [
	parent := aModel
]

{ #category : #accessing }
PenDisplayComponent >> position [
	^ position
]

{ #category : #accessing }
PenDisplayComponent >> position: aPoint [
	position := aPoint
]

{ #category : #printing }
PenDisplayComponent >> printOn: aStream [
	aStream nextPutAll: self className.
	self key ifNotNil: [ 
		aStream
			nextPutAll: ': ';
			nextPutAll: 	self key printString
	 ]
]

{ #category : #accessing }
PenDisplayComponent >> pseudoClasses [
	^ pseudoClasses
]

{ #category : #building }
PenDisplayComponent >> refresh [
	self isBuilt ifTrue: [ self dresser dress ]
]

{ #category : #accessing }
PenDisplayComponent >> removeStyleClass: aSymbol [
	self styleClasses remove: aSymbol.
	self refresh
]

{ #category : #accessing }
PenDisplayComponent >> size [
	^ self width pref @ self height pref
]

{ #category : #accessing }
PenDisplayComponent >> size: aPoint [
	self width: aPoint x.
	self height: aPoint y.
]

{ #category : #accessing }
PenDisplayComponent >> styleClasses [
	^ styleClasses
]

{ #category : #accessing }
PenDisplayComponent >> styleId [
	^ self key
]

{ #category : #accessing }
PenDisplayComponent >> styleName [
	^ self subclassResponsibility 
]

{ #category : #accessing }
PenDisplayComponent >> stylesheet [ 
	^ stylesheet
]

{ #category : #accessing }
PenDisplayComponent >> stylesheet: aStylesheet [
	stylesheet := aStylesheet.
	self isBuilt ifTrue: [ self refresh ]
]

{ #category : #accessing }
PenDisplayComponent >> visible: aBoolean [
	visible := aBoolean
]

{ #category : #'api - events' }
PenDisplayComponent >> whenEvent: aSymbol on: aComponent do: aBlock [
	| binding |
	self deprecated: ''.
	binding := PenEventBinding for: aSymbol do: aBlock.
	binding source: self.
	binding target: (aComponent ifNil: [ self ]).
	eventBindings add: binding.
]

{ #category : #'api - events' }
PenDisplayComponent >> whenEvent: aSymbol on: aComponent perform: aFunction with: aPerformer [
	| binding |
	self deprecated: ''.
	binding := PenEventBinding for: aSymbol perform: aFunction on: aPerformer.
	binding source: self.
	binding target: (aComponent ifNil: [ self ]).
	eventBindings add: binding.
]

{ #category : #'api - events' }
PenDisplayComponent >> whenEvents: aListOfSymbols on: aComponent do: aBlock [
	| binding |
	self deprecated: ''.
	binding := PenEventBinding forAll: aListOfSymbols do: aBlock.
	binding source: self.
	binding target: (aComponent ifNil: [ self ]).
	eventBindings add: binding.
]

{ #category : #'api - events' }
PenDisplayComponent >> whenEvents: aListOfSymbols on: aComponent perform: aFunction with: aPerformer [
	| binding |
	self deprecated: ''.
	binding := PenEventBinding forAll: aListOfSymbols perform: aFunction on: aPerformer.
	binding source: self.
	binding target: (aComponent ifNil: [ self ]).
	eventBindings add: binding.
]

{ #category : #accessing }
PenDisplayComponent >> width [ 
	^ width
]

{ #category : #accessing }
PenDisplayComponent >> width: aLength [
	width := aLength asLength
]
