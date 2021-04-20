"
A display component is a concrete visual component of the user interface.
"
Class {
	#name : #PenDisplayComponent,
	#superclass : #PenComponent,
	#traits : 'TPssStyleable',
	#classTraits : 'TPssStyleable classTrait',
	#instVars : [
		'dresser',
		'engine',
		'dressersMap',
		'style',
		'customStyle',
		'stylesheet',
		'styleClasses',
		'visible',
		'built',
		'dirty',
		'parent',
		'transformation',
		'alignment',
		'pseudoClasses',
		'engineElement',
		'dirtyLock'
	],
	#category : #'Penfeld-Components'
}

{ #category : #accessing }
PenDisplayComponent class >> styleName [
	^ self subclassResponsibility 
]

{ #category : #accessing }
PenDisplayComponent class >> systemIcon [ 
	^ self iconNamed: #objects
]

{ #category : #accessing }
PenDisplayComponent >> activatePseudoClass: aSymbol [
	self activatePseudoClass: aSymbol value: nil.
]

{ #category : #accessing }
PenDisplayComponent >> activatePseudoClass: aSymbol value: anArg [
	self pseudoClasses add: aSymbol -> anArg.
	self isBuilt ifTrue: [ 
		self buildStyle.
		self refresh.
	].
]

{ #category : #style }
PenDisplayComponent >> addCustomStyle: aPropertyModel [
	| decl |
	decl := PssModelPropertyDeclaration new.
	decl property: aPropertyModel class symbol.
	decl model: aPropertyModel.
	customStyle add: decl. 
	self isBuilt ifTrue: [ self buildStyle ].
]

{ #category : #style }
PenDisplayComponent >> addCustomStyle: aPropertyModel named: aSymbol [
	| decl |
	decl := PssModelPropertyDeclaration new.
	decl property: aSymbol.
	decl model: aPropertyModel.
	customStyle add: decl. 
	self isBuilt ifTrue: [ self buildStyle ].
]

{ #category : #accessing }
PenDisplayComponent >> addStyleClass: aSymbol [
	self styleClasses 
		detect: [ :e | e = aSymbol ]
		ifFound: [ ^ self ]
		ifNone: [ 
			self styleClasses add: aSymbol.
			self isBuilt ifTrue: [ 
				self buildStyle.
				self refresh.	
			] ]
	
]

{ #category : #accessing }
PenDisplayComponent >> addStyleClasses: aList [
	aList do: [ :aSymbol | self addStyleClass: aSymbol ].
]

{ #category : #building }
PenDisplayComponent >> build [ 
	| eventStrategy |
	self isBuilt ifTrue: [ ^ self ].
	
	self stylesheet ifNil: [ self stylesheet: self chooseStylesheet ].
	self buildStyle.
	
	self dresser ifNil: [ self dresser: (self chooseDresserFor: self) new ].
	self dresser initEngineElementFor: self.
	self dresser dress: self.
	
	self isVisible
		ifTrue: [ self dresser show: self ]
		ifFalse: [ self dresser hide: self ].
	
	eventStrategy := self dresser eventStrategy.
	eventBindings do: [ :eventBinding | (eventStrategy tryToBind: eventBinding)
		ifFalse: [ "self traceCr: 'Can not bind ', eventBinding symbol" ] ].

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
PenDisplayComponent >> buildStyle [
	self stylesheet ifNil: [ ^ self ].
	
	style := self stylesheet reducedDeclarationsFor: self.
	
	"Add custom style"
	customStyle do: [ :customDecl |
		style
			detect: [ :decl | customDecl property = decl property ]	
			ifFound: [ :decl | decl model overwriteMerge: customDecl model ]
			ifNone: [ style add: customDecl ]
	]
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
		ifNil: [ 	^ PenDefaultStylesheet current ]
	
	
]

{ #category : #accessing }
PenDisplayComponent >> clearAllPseudoClass [
	self pseudoClasses removeAll.
	self refresh.
]

{ #category : #accessing }
PenDisplayComponent >> deactivatePseudoClass: aSymbol [
	| pseudoClass |
	pseudoClass := pseudoClasses 
		detect: [ :association | association key = aSymbol ]
		ifNone: [ ^ self ].
	pseudoClasses remove: pseudoClass. 
	self buildStyle.
	self refresh
]

{ #category : #accessing }
PenDisplayComponent >> dresser [
	^ dresser
]

{ #category : #accessing }
PenDisplayComponent >> dresser: aDresser [
	dresser := aDresser.
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

{ #category : #private }
PenDisplayComponent >> forceRefresh [
	"Do not use me, I am a private / debug utility method to force redraw."
	self dresser dress: self.
]

{ #category : #style }
PenDisplayComponent >> getCustomStyle: aSymbol [
	customStyle 
		detect: [ :decl | decl property = aSymbol ]
		ifFound: [ :decl | ^ decl model ]
		ifNone: [ ^ nil ]
]

{ #category : #style }
PenDisplayComponent >> getStyle: aSymbol [
	self isBuilt ifFalse: [ ^ nil ].
	style 
		detect: [ :decl | decl property = aSymbol ]
		ifFound: [ :decl | ^ decl model ]
		ifNone: [ ^ nil ]
]

{ #category : #accessing }
PenDisplayComponent >> height [
	^ (self getCustomStyle: #height)
		ifNotNil: [ :model | model value ]
		ifNil: [ 	0 ].
]

{ #category : #accessing }
PenDisplayComponent >> height: aNumber [ 
	| model declaration |
	model := PssLengthModel new value: aNumber.
	declaration := self getCustomStyle: #height.
	declaration 
		ifNotNil: [ declaration model overwriteMerge: model ]
		ifNil: [ 	self addCustomStyle: model named: #height ].
	self refresh
]

{ #category : #accessing }
PenDisplayComponent >> hide [ 
	self visible: false
]

{ #category : #initialization }
PenDisplayComponent >> initialize [
	super initialize.
	visible := true.
	built := false.
	dirty := false.
	dirtyLock := Semaphore forMutualExclusion.
	styleClasses := OrderedCollection new.
	pseudoClasses := OrderedCollection new.
	customStyle := OrderedCollection new.
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

{ #category : #private }
PenDisplayComponent >> loopRefresh [
	dirty ifFalse: [ ^ self ].
	self isBuilt ifFalse: [ ^ self ].
	dirtyLock critical:
		[ self dresser dress: self. 
		dirty := false ].
]

{ #category : #accessing }
PenDisplayComponent >> matchedRules [
	^ self stylesheet matchingRulesFor: self.
]

{ #category : #opening }
PenDisplayComponent >> open [
	Penfeld open: self
]

{ #category : #opening }
PenDisplayComponent >> openInWindow [
	| view |
	self isBuilt ifFalse: [ self build ].
	view := PenView with: self.
	view openInWindow
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
PenDisplayComponent >> position: aPoint [
	| model positionDcl |
	super position: aPoint.
	model := PssPositionModel new 
		position: PssPosition relative;
		left: aPoint x;
		top: aPoint y.
	positionDcl := self getCustomStyle: #position.
	positionDcl 
		ifNotNil: [ positionDcl model overwriteMerge: model ]
		ifNil: [ 	self addCustomStyle: model ].
	self refresh
]

{ #category : #accessing }
PenDisplayComponent >> pseudoClasses [
	^ pseudoClasses
]

{ #category : #building }
PenDisplayComponent >> refresh [
	dirtyLock critical: [ dirty := true ].
]

{ #category : #accessing }
PenDisplayComponent >> removeStyleClass: aSymbol [
	self styleClasses remove: aSymbol ifAbsent: [^self].
	self refresh
]

{ #category : #accessing }
PenDisplayComponent >> show [ 
	self visible: true
]

{ #category : #accessing }
PenDisplayComponent >> size [
	| width height |
	width := (self getCustomStyle: #width)
		ifNotNil: [ :model | model value ]
		ifNil: [ 0 ].
	height := (self getCustomStyle: #height)
		ifNotNil: [ :model | model value ]
		ifNil: [ 0 ].
	^ width @ height
]

{ #category : #accessing }
PenDisplayComponent >> size: aPoint [ 
	self width: aPoint x.
	self height: aPoint y.
]

{ #category : #accessing }
PenDisplayComponent >> style [
	^ style
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
	^ self class styleName
]

{ #category : #accessing }
PenDisplayComponent >> stylesheet [ 
	^ stylesheet
]

{ #category : #accessing }
PenDisplayComponent >> stylesheet: aStylesheet [
	stylesheet := aStylesheet.
	self buildStyle.
	self refresh
]

{ #category : #accessing }
PenDisplayComponent >> visible: aBoolean [
	visible = aBoolean ifTrue: [ ^ self ].
	visible := aBoolean.
	self refresh 
]

{ #category : #accessing }
PenDisplayComponent >> width [
	^ (self getCustomStyle: #width)
		ifNotNil: [ :model | model value ]
		ifNil: [ 	0 ].
]

{ #category : #accessing }
PenDisplayComponent >> width: aNumber [ 
	| model declaration |
	model := PssLengthModel new value: aNumber.
	declaration := self getCustomStyle: #width.
	declaration 
		ifNotNil: [ declaration model overwriteMerge: model ]
		ifNil: [ 	self addCustomStyle: model named: #width ].
	self refresh
]
