Class {
	#name : #CssCompoundSelector,
	#superclass : #CssSelector,
	#instVars : [
		'selectors',
		'relationships'
	],
	#category : #'CSS-Core'
}

{ #category : #'as yet unclassified' }
CssCompoundSelector class >> selectors: selectors relationships: relationships [
	^ self new
		selectors: selectors;
		relationships: relationships;
		yourself
]

{ #category : #testing }
CssCompoundSelector >> = aSelector [
	^ aSelector isSimpleSelector not and: [ self selectors = aSelector selectors ]
]

{ #category : #accessing }
CssCompoundSelector >> initialize [
	super initialize.
	relationships := OrderedCollection new.
	selectors := OrderedCollection new
]

{ #category : #testing }
CssCompoundSelector >> matchesStyleable: aStyleable [
	^ self matchesStyleable: aStyleable selectorIndex: selectors size
]

{ #category : #testing }
CssCompoundSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList [
	
	^ self
		matchesStyleable: aStyleable
		pseudoClassStates: aPseudoClassStateList
		selectorIndex: self selectors size
]

{ #category : #testing }
CssCompoundSelector >> matchesStyleable: aNode pseudoClassStates: aPseudoClassStateList selectorIndex: aSelectorIndex [
	| selector parent relation |
	aSelectorIndex = 0
		ifTrue: [ ^ true ].	"no more selectors, so it matches"
	selector := selectors at: aSelectorIndex.
	(selector matchesStyleable: aNode pseudoClassStates: aPseudoClassStateList selectorIndex: aSelectorIndex)
		ifFalse: [ ^ false ].
	aSelectorIndex = 1
		ifTrue: [ ^ true ].	"no more selectors, so it matches"
	relation := relationships at: aSelectorIndex - 1.
	parent := aNode parent.
	parent ifNil:[^ false].
	relation isChild
		ifTrue: [ ^ self matchesStyleable: parent pseudoClassStates: aPseudoClassStateList allButLast selectorIndex: aSelectorIndex - 1 ].
	relation isDescendant
		ifTrue:
			[ | thePseudoClassStateList |
			thePseudoClassStateList := aPseudoClassStateList.
			[ parent isNotNil ]
				whileTrue:
					[ thePseudoClassStateList := thePseudoClassStateList allButLast.
					(self matchesStyleable: parent pseudoClassStates: thePseudoClassStateList selectorIndex: aSelectorIndex - 1)
						ifTrue: [ ^ true ].
					parent := parent parent ] ].
	^ false
]

{ #category : #testing }
CssCompoundSelector >> matchesStyleable: aStyleable selectorIndex: aSelectorIndex [
	^ self
		matchesStyleable: aStyleable
		pseudoClassStates: OrderedCollection new
		selectorIndex: aSelectorIndex
]

{ #category : #accessing }
CssCompoundSelector >> relationships [
	^ relationships
]

{ #category : #accessing }
CssCompoundSelector >> relationships: anObject [
	relationships := anObject
]

{ #category : #accessing }
CssCompoundSelector >> rule: aRule [
	super rule: aRule.
	self selectors do: [ :item | item rule: aRule ]
]

{ #category : #accessing }
CssCompoundSelector >> selectors [
	^ selectors
]

{ #category : #accessing }
CssCompoundSelector >> selectors: aCollection [
	aCollection
		do: [ :item |  self selectors add: (item rule: self rule; yourself) ]
]

{ #category : #updating }
CssCompoundSelector >> updateMatching [
	matchOnId := self selectors anySatisfy: [ :s | s matchesOnId ].
	matchOnName := self selectors anySatisfy: [ :s | s matchesOnName ].
	matchOnStyleClass := self selectors anySatisfy: [ :s | s matchesOnStyleClass ]
]

{ #category : #updating }
CssCompoundSelector >> updateSpecificity [
	| idCount styleClassCount nameCount pseudoClassCount |
	idCount := self selectors sum: [ :s | s idCount ].
	styleClassCount := self selectors sumNumbers: [ :s | s styleClassCount ].
	pseudoClassCount := self selectors sumNumbers: [ :s | s pseudoClassCount ].
	nameCount := self selectors sum: [ :s | s nameCount ].
	specificity := idCount << 8 | (pseudoClassCount << 4) | styleClassCount | nameCount
]
