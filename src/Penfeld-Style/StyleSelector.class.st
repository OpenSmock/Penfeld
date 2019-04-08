Class {
	#name : #StyleSelector,
	#superclass : #Object,
	#instVars : [
		'rule',
		'specificity',
		'matchOnId',
		'matchOnName',
		'matchOnStyleClass'
	],
	#category : #'Style-Core'
}

{ #category : #'as yet unclassified' }
StyleSelector class >> from: anObject [
	anObject isSymbol
		ifTrue: [ ^ self fromSymbol: anObject ].
	(anObject isArray and: [ anObject size = 1 ])
		ifTrue: [ ^ self fromSymbol: anObject first ].
	anObject isArray
		ifTrue: [ ^ self fromSymbols: anObject ]
]

{ #category : #'as yet unclassified' }
StyleSelector class >> fromSymbol: aSymbol [
	| parts selector |
	parts := BlStyleHelper splitSelectorSymbol: aSymbol.
	selector := BlStyleSimpleSelector new
		name: nil;
		styleClasses: {parts first asSymbol};
		id: nil;
		yourself.
	parts size > 1
		ifTrue:
			[ 
			selector pseudoClasses
				addAll: (parts allButFirst collect: [ :each | BlState fromSymbol: each asSymbol ]) ].
	selector update.
	^ selector
]

{ #category : #'as yet unclassified' }
StyleSelector class >> fromSymbols: aSymbolList [
	| selectors relationships |
	selectors := OrderedCollection new.
	relationships := OrderedCollection new.
	aSymbolList
		do:
			[ :aSymb | 
			aSymb = #>
				ifTrue: [ relationships add: CSSRelation CHILD ]
				ifFalse:
					[ 
					(aSymb = aSymbolList first) not
						ifTrue: [ relationships add: CSSRelation DESCENDANT ].
					selectors add: (self fromSymbol: aSymb) ] ].
	^ (CSSCompoundSelector selectors: selectors relationships: relationships)
		update;
		yourself
]

{ #category : #testing }
StyleSelector >> isSimpleSelector [
	^ false
]

{ #category : #testing }
StyleSelector >> matchesOnId [
	^ matchOnId
]

{ #category : #testing }
StyleSelector >> matchesOnName [
	^ matchOnName 
]

{ #category : #testing }
StyleSelector >> matchesOnStyleClass [ 
	^ matchOnStyleClass 
]

{ #category : #testing }
StyleSelector >> matchesStyleable: aStyleable [
	self subclassResponsibility 
]

{ #category : #testing }
StyleSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList [
	self subclassResponsibility 
]

{ #category : #testing }
StyleSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList selectorIndex: aSelectorIndex [
	self subclassResponsibility 
]

{ #category : #accessing }
StyleSelector >> origin [
	^ self rule origin
]

{ #category : #accessing }
StyleSelector >> rule [
	^ rule
]

{ #category : #accessing }
StyleSelector >> rule: anObject [
	rule := anObject
]

{ #category : #accessing }
StyleSelector >> specificity [
	^ specificity
]

{ #category : #updating }
StyleSelector >> update [
	self updateMatching.
	self updateSpecificity 
]

{ #category : #updating }
StyleSelector >> updateMatching [
	self subclassResponsibility 
]

{ #category : #updating }
StyleSelector >> updateSpecificity [
	self subclassResponsibility
]
