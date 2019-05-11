Class {
	#name : #PenDisplayComponent,
	#superclass : #PenComponent,
	#traits : 'TPssStyleable',
	#classTraits : 'TPssStyleable classTrait',
	#instVars : [
		'dresser',
		'engine',
		'dressersMap',
		'stylesheet',
		'styleClasses',
		'visible',
		'built',
		'parent',
		'position',
		'width',
		'height',
		'transformation',
		'alignment',
		'pseudoClasses',
		'engineElement'
	],
	#category : #'Penfeld-Components'
}

{ #category : #accessing }
PenDisplayComponent >> activatePseudoClass: aSymbol [
	self pseudoClasses add: aSymbol -> nil.
	self refresh.
]

{ #category : #accessing }
PenDisplayComponent >> activatePseudoClass: aSymbol value: anArg [
	self pseudoClasses add: aSymbol -> anArg.
	self refresh.
]

{ #category : #accessing }
PenDisplayComponent >> addStyleClass: aSymbol [
	self styleClasses add: aSymbol.
	self refresh.
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
	self refresh.
]

{ #category : #accessing }
PenDisplayComponent >> deactivatePseudoClass: aSymbol [
	pseudoClasses := pseudoClasses reject: [ :association |
		association key = aSymbol ].
	self refresh.
]

{ #category : #accessing }
PenDisplayComponent >> dresser [
	^ dresser
]

{ #category : #accessing }
PenDisplayComponent >> dresser: aDresser [
	dresser := aDresser.
	aDresser component: self.
	self refresh
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
PenDisplayComponent >> engineElement [
	^ engineElement
]

{ #category : #accessing }
PenDisplayComponent >> engineElement: anObject [
	engineElement := anObject
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
	visible := true.
	built := false.
	styleClasses := OrderedCollection new.
	pseudoClasses := OrderedCollection new.
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
	self refresh.
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
