Class {
	#name : #PenDisplayComponent,
	#superclass : #PenComponent,
	#traits : 'TStyStyleable',
	#classTraits : 'TStyStyleable classTrait',
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

{ #category : #accessing }
PenDisplayComponent >> activatePseudoClass: aSymbol [
	self pseudoClasses add: aSymbol.
	self refresh
]

{ #category : #private }
PenDisplayComponent >> addCallback: aBlock for: anEventSymbol [
	| binding |
	binding := PenEventBinding for: anEventSymbol do: aBlock.
	eventBindings add: binding.
	^ binding
]

{ #category : #private }
PenDisplayComponent >> addCallback: aBlock forAll: anEventSymbolList [
	| binding |
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
	eventBindings do: 
	[ 
		:eventBinding | 
		(eventBinding isAutoBound and: [ eventBinding isSimpleEvent ])
			ifTrue: [ eventStrategy install: eventBinding symbol on: self ]
	].

	built := true.
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
			self engine: PenEngine default.
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

{ #category : #accessing }
PenDisplayComponent >> deactivatePseudoClass: aSymbol [
	self pseudoClasses remove: aSymbol ifAbsent: [^ self].
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
	aDresser model: self.
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
	pseudoClasses := Set new.
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

{ #category : #'api - events' }
PenDisplayComponent >> on: aListOfSymbols do: aBlock [
	self addCallback: aBlock forAll: aListOfSymbols 
]

{ #category : #opening }
PenDisplayComponent >> openInInternalWindow [
	| view |
	self isBuilt ifFalse: [ self build ].
	view := PenView with: self.
	view openInInternalWindow
]

{ #category : #opening }
PenDisplayComponent >> openInWindow [
	^ self notYetImplemented 
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

{ #category : #accessing }
PenDisplayComponent >> width [ 
	^ width
]

{ #category : #accessing }
PenDisplayComponent >> width: aLength [
	width := aLength asLength
]
