Class {
	#name : #PenDisplayComponent,
	#superclass : #PenModel,
	#traits : 'TCSSStyleable',
	#classTraits : 'TCSSStyleable classTrait',
	#instVars : [
		'dresser',
		'interactor',
		'engine',
		'dressersMap',
		'stylesheet',
		'styleClasses',
		'callbacks',
		'visible',
		'built',
		'parent',
		'position',
		'width',
		'height',
		'transformation',
		'alignment',
		'pseudoClasses'
	],
	#category : #'Penfeld-Core'
}

{ #category : #accessing }
PenDisplayComponent >> activatePseudoClass: aSymbol [
	self pseudoClasses add: aSymbol.
	self refresh
]

{ #category : #private }
PenDisplayComponent >> addAutoInstalledCallback: aBlock for: anEventSymbol [
	| binding |
	binding := PenEventBinding for: anEventSymbol do: aBlock.
	binding autoInstall.
	callbacks add: binding.
]

{ #category : #private }
PenDisplayComponent >> addCallback: aBlock for: anEventSymbol [
	| binding |
	binding := PenEventBinding for: anEventSymbol do: aBlock.
	callbacks add: binding.
]

{ #category : #private }
PenDisplayComponent >> addCallback: aBlock forAll: anEventSymbolList [
	| binding |
	binding := PenEventBinding forAll: anEventSymbolList do: aBlock.
	callbacks add: binding.
]

{ #category : #accessing }
PenDisplayComponent >> addStyleClass: aSymbol [
	self styleClasses add: aSymbol.
	self refreshStyle
]

{ #category : #building }
PenDisplayComponent >> build [ 
	| eventStrategy |
	self isBuilt ifTrue: [ ^ self ].
	
	self stylesheet ifNil: [ self stylesheet: PenStylesheet current ].
	
	self dresser ifNil: [ self dresser: (self chooseDresserFor: self) new ].
	self dresser initInteractor.
	self dresser dress.
	
	eventStrategy := self dresser eventStrategy.
	callbacks do: 
	[ 
		:eventBinding | 
		(eventBinding isInstalled and: [ eventBinding isSimpleEvent ])
			ifTrue: [ eventStrategy install: eventBinding symbol on: self ]
	].

	built := true.
]

{ #category : #'private-accessing' }
PenDisplayComponent >> callbacks [
	^ callbacks
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

{ #category : #accessing }
PenDisplayComponent >> clearAllPseudoClass [
	self pseudoClasses removeAll.
	self refreshStyle 
]

{ #category : #accessing }
PenDisplayComponent >> deactivatePseudoClass: aSymbol [
	self pseudoClasses remove: aSymbol ifAbsent: [^ self].
	self refresh
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
PenDisplayComponent >> engine [
	^ engine
]

{ #category : #accessing }
PenDisplayComponent >> engine: anObject [
	engine := anObject
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
	built := false.
	styleClasses := OrderedCollection new.
	pseudoClasses := Set new.
	callbacks := OrderedCollection new.
]

{ #category : #accessing }
PenDisplayComponent >> interactor [
	^ interactor
]

{ #category : #accessing }
PenDisplayComponent >> interactor: anInteractor [
	interactor := anInteractor
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

{ #category : #accessing }
PenDisplayComponent >> pseudoClasses [
	^ pseudoClasses
]

{ #category : #building }
PenDisplayComponent >> refresh [
	self isBuilt ifTrue: [ self dresser dress ]
]

{ #category : #building }
PenDisplayComponent >> refreshStyle [
	self deprecated: 'use refresh'.
	self isBuilt ifTrue: [ self dresser dress ]
]

{ #category : #accessing }
PenDisplayComponent >> removeStyleClass: aSymbol [
	self styleClasses remove: aSymbol.
	self refreshStyle 
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
