Class {
	#name : #StyleSimpleSelector,
	#superclass : #StyleSelector,
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
	#category : #'Style-Core'
}

{ #category : #testing }
StyleSimpleSelector >> = aSelector [
	^ (aSelector isSimpleSelector) and:[
		((self name = aSelector name 
		and: [ self id = aSelector id ]) 
		and: [ self pseudoClasses = aSelector pseudoClasses ])
		and: [ self styleClasses = aSelector styleClasses ]]
]

{ #category : #accessing }
StyleSimpleSelector >> id [
	^ id
]

{ #category : #accessing }
StyleSimpleSelector >> id: anObject [
	id := anObject
]

{ #category : #accessing }
StyleSimpleSelector >> idCount [
	^ idCount
]

{ #category : #accessing }
StyleSimpleSelector >> initialize [
	super initialize.
	pseudoClasses := Dictionary new.
	styleClasses := OrderedCollection new
]

{ #category : #testing }
StyleSimpleSelector >> isSimpleSelector [
	^ true
]

{ #category : #testing }
StyleSimpleSelector >> matchesPseudoClasseState: aPseudoClassState [
	| found |
	pseudoClasses keysAndValuesDo: [ :sKey :sValue |
		found := false.
		aPseudoClassState
			select: [ :cAssociation | cAssociation key = sKey ]
			thenDo: [ :cAssociation | | cValue | 
				sValue 
					ifNil: [ found := true ]
					ifNotNil: [ 
						cValue := cAssociation value.	
						(sValue respondsTo: cValue)
							ifTrue: [ (sValue perform: cValue) ifTrue: [ found := true ] ]
							ifFalse: [ found := cValue = sValue ]
					].
			].
		found ifFalse: [ ^ false ]
	].
	^ true
]

{ #category : #testing }
StyleSimpleSelector >> matchesStyleClasses: aStyleClassList [
	^ aStyleClassList includesAll: styleClasses
]

{ #category : #testing }
StyleSimpleSelector >> matchesStyleable: aStyleable [
	self matchesOnName
		ifTrue: [ (self nameMatches: aStyleable styleName) ifFalse: [ ^ false ] ].
	self matchesOnId
		ifTrue: [self id = aStyleable styleId ifFalse: [ ^ false ] ].
	self matchesOnStyleClass
		ifTrue:[(self matchesStyleClasses: aStyleable styleClasses ) ifFalse: [ ^ false ] ].
	^ self matchesPseudoClasseState: aStyleable pseudoClasses
]

{ #category : #testing }
StyleSimpleSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList [
	^ self
		matchesStyleable: aStyleable
		pseudoClassStates: aPseudoClassStateList
		selectorIndex: aPseudoClassStateList size
]

{ #category : #testing }
StyleSimpleSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList selectorIndex: aSelectorIndex [
	(self matchesStyleable: aStyleable)
		ifFalse: [ ^ false ].
	aPseudoClassStateList
		ifNotEmpty:
			[ :c | (self matchesPseudoClasseState: (c last))
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
StyleSimpleSelector >> name [
	^ name
]

{ #category : #accessing }
StyleSimpleSelector >> name: anObject [
	name := anObject
]

{ #category : #accessing }
StyleSimpleSelector >> nameCount [
	^ nameCount
]

{ #category : #testing }
StyleSimpleSelector >> nameMatches: aClassName [
	matchOnName
		ifFalse: [ ^ false ].
	^ name = aClassName
]

{ #category : #printing }
StyleSimpleSelector >> printOn: aStream [
	self name ifNotNil: [ :n | aStream nextPutAll: n ].
	self id ifNotNil: [ :i | aStream nextPutAll: i ].
	self styleClasses
		ifNotEmpty: [ :cls | 
			aStream
				nextPut: $.;
				nextPutAll: (cls joinUsing: '.') ].
	self pseudoClasses
		keysAndValuesDo: [ :k :v | 
			aStream
				nextPut: $:;
				nextPutAll: k.
			v ifNotNil: [ 
				aStream 
					nextPut: $(;
					nextPutAll: v printString;
					nextPut: $) ] ]
]

{ #category : #accessing }
StyleSimpleSelector >> pseudoClassCount [
	^ pseudoClassCount
]

{ #category : #accessing }
StyleSimpleSelector >> pseudoClasses [
	^ pseudoClasses
]

{ #category : #accessing }
StyleSimpleSelector >> pseudoClasses: anObject [
	pseudoClasses := anObject
]

{ #category : #accessing }
StyleSimpleSelector >> styleClassCount [
	^ styleClassCount
]

{ #category : #accessing }
StyleSimpleSelector >> styleClasses [
	^ styleClasses
]

{ #category : #accessing }
StyleSimpleSelector >> styleClasses: anObject [
	styleClasses := anObject
]

{ #category : #updating }
StyleSimpleSelector >> updateMatching [
	matchOnId := id isNotNil and: [ id isNotEmpty ].
	matchOnName := name isNotNil and: [ name isNotEmpty and: [ (name = '*') not ] ].
	matchOnStyleClass := styleClasses isNotEmpty.
]

{ #category : #updating }
StyleSimpleSelector >> updateSpecificity [
	idCount := self matchesOnId asBit.
	styleClassCount := self styleClasses size.
	pseudoClassCount := self pseudoClasses size.
	nameCount := self matchesOnName asBit.
	specificity := idCount << 8 | (pseudoClassCount << 4) | styleClassCount | nameCount
]
