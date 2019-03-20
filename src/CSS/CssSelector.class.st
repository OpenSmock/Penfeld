Class {
	#name : #CssSelector,
	#superclass : #Object,
	#instVars : [
		'rule',
		'specificity',
		'matchOnId',
		'matchOnName',
		'matchOnStyleClass'
	],
	#category : #'CSS-Core'
}

{ #category : #'as yet unclassified' }
CssSelector class >> from: anObject [
	anObject isSymbol
		ifTrue: [ ^ self fromSymbol: anObject ].
	(anObject isArray and: [ anObject size = 1 ])
		ifTrue: [ ^ self fromSymbol: anObject first ].
	anObject isArray
		ifTrue: [ ^ self fromSymbols: anObject ]
]

{ #category : #'as yet unclassified' }
CssSelector class >> fromSymbol: aSymbol [
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
CssSelector class >> fromSymbols: aSymbolList [
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
CssSelector >> isSimpleSelector [
	^ false
]

{ #category : #testing }
CssSelector >> matchesOnId [
	^ matchOnId
]

{ #category : #testing }
CssSelector >> matchesOnName [
	^ matchOnName 
]

{ #category : #testing }
CssSelector >> matchesOnStyleClass [ 
	^ matchOnStyleClass 
]

{ #category : #testing }
CssSelector >> matchesStyleable: aStyleable [
	self subclassResponsibility 
]

{ #category : #testing }
CssSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList [
	self subclassResponsibility 
]

{ #category : #testing }
CssSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList selectorIndex: aSelectorIndex [
	self subclassResponsibility 
]

{ #category : #accessing }
CssSelector >> origin [
	^ self rule origin
]

{ #category : #accessing }
CssSelector >> rule [
	^ rule
]

{ #category : #accessing }
CssSelector >> rule: anObject [
	rule := anObject
]

{ #category : #accessing }
CssSelector >> specificity [
	^ specificity
]

{ #category : #updating }
CssSelector >> update [
	self updateMatching.
	self updateSpecificity 
]

{ #category : #updating }
CssSelector >> updateMatching [
	self subclassResponsibility 
]

{ #category : #updating }
CssSelector >> updateSpecificity [
	self subclassResponsibility
]
