Class {
	#name : #CssSimpleSelector,
	#superclass : #CssSelector,
	#instVars : [
		'name',
		'styleClasses',
		'id',
		'pseudoClasses',
		'idCount',
		'styleClassCount',
		'nameCount',
		'pseudoClassCount'
	],
	#category : #'CSS-Core'
}

{ #category : #testing }
CssSimpleSelector >> = aSelector [
	^ (aSelector isSimpleSelector) and:[
		((self name = aSelector name 
		and: [ self id = aSelector id ]) 
		and: [ self pseudoClasses = aSelector pseudoClasses ])
		and: [ self styleClasses = aSelector styleClasses ]]
]

{ #category : #accessing }
CssSimpleSelector >> id [
	^ id
]

{ #category : #accessing }
CssSimpleSelector >> id: anObject [
	id := anObject
]

{ #category : #accessing }
CssSimpleSelector >> idCount [
	^ idCount
]

{ #category : #accessing }
CssSimpleSelector >> initialize [
	super initialize.
	pseudoClasses := OrderedCollection new.
	styleClasses := OrderedCollection new
]

{ #category : #testing }
CssSimpleSelector >> isSimpleSelector [
	^ true
]

{ #category : #testing }
CssSimpleSelector >> matchesPseudoClasseState: aPseudoClassState [
	^ aPseudoClassState includesAll: pseudoClasses
]

{ #category : #testing }
CssSimpleSelector >> matchesStyleClasses: aStyleClassList [
	^ aStyleClassList includesAll: styleClasses
]

{ #category : #testing }
CssSimpleSelector >> matchesStyleable: aStyleable [
	self matchesOnName
		ifTrue: [ (self nameMatches: aStyleable styleName) ifFalse: [ ^ false ] ].
	self matchesOnId
		ifTrue: [self id = aStyleable styleId ifFalse: [ ^ false ] ].
	self matchesOnStyleClass
		ifTrue:[(self matchesStyleClasses: aStyleable styleClasses ) ifFalse: [ ^ false ] ].
	^ self matchesPseudoClasseState: aStyleable pseudoClasses
]

{ #category : #testing }
CssSimpleSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList [
	^ self
		matchesStyleable: aStyleable
		pseudoClassStates: aPseudoClassStateList
		selectorIndex: aPseudoClassStateList size
]

{ #category : #testing }
CssSimpleSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList selectorIndex: aSelectorIndex [
	(self matchesStyleable: aStyleable)
		ifFalse: [ ^ false ].
	aPseudoClassStateList
		ifNotEmpty:
			[ :c | (self matchesPseudoClasseState: (c last))
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
CssSimpleSelector >> name [
	^ name
]

{ #category : #accessing }
CssSimpleSelector >> name: anObject [
	name := anObject
]

{ #category : #accessing }
CssSimpleSelector >> nameCount [
	^ nameCount
]

{ #category : #testing }
CssSimpleSelector >> nameMatches: aClassName [
	matchOnName
		ifFalse: [ ^ false ].
	^ name = aClassName
]

{ #category : #printing }
CssSimpleSelector >> printOn: aStream [
	self name ifNotNil: [ :n | aStream nextPutAll: n ].
	self id ifNotNil: [ :i | aStream nextPutAll: i ].
	self styleClasses
		ifNotEmpty: [ :cls | 
			aStream
				nextPut: $.;
				nextPutAll: (cls joinUsing: '.') ].
	self pseudoClasses
		ifNotEmpty: [ :pcls | 
			aStream
				nextPut: $:;
				nextPutAll: (pcls joinUsing: ':') ]
]

{ #category : #accessing }
CssSimpleSelector >> pseudoClassCount [
	^ pseudoClassCount
]

{ #category : #accessing }
CssSimpleSelector >> pseudoClasses [
	^ pseudoClasses
]

{ #category : #accessing }
CssSimpleSelector >> pseudoClasses: anObject [
	pseudoClasses := anObject
]

{ #category : #accessing }
CssSimpleSelector >> styleClassCount [
	^ styleClassCount
]

{ #category : #accessing }
CssSimpleSelector >> styleClasses [
	^ styleClasses
]

{ #category : #accessing }
CssSimpleSelector >> styleClasses: anObject [
	styleClasses := anObject
]

{ #category : #updating }
CssSimpleSelector >> updateMatching [
	matchOnId := id isNotNil and: [ id isNotEmpty ].
	matchOnName := name isNotNil and: [ name isNotEmpty and: [ (name = '*') not ] ].
	matchOnStyleClass := styleClasses isNotEmpty.
]

{ #category : #updating }
CssSimpleSelector >> updateSpecificity [
	idCount := self matchesOnId asBit.
	styleClassCount := self styleClasses size.
	pseudoClassCount := self pseudoClasses size.
	nameCount := self matchesOnName asBit.
	specificity := idCount << 8 | (pseudoClassCount << 4) | styleClassCount | nameCount
]
