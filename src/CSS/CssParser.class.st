Class {
	#name : #CssParser,
	#superclass : #CssGrammar,
	#category : #'CSS-Utils'
}

{ #category : #'grammar value' }
CssParser >> arrayToken [
	^ super arrayToken
		==>
			[ :nodes | CssArrayValue value: (nodes parsedValue first collect: [ :item | item value ]) ]
]

{ #category : #'grammar relation' }
CssParser >> childRelationToken [
	^ super childRelationToken ==> [ :nodes| CssRelation CHILD ]
]

{ #category : #'grammar selector' }
CssParser >> classSelectorToken [
	^ super classSelectorToken ==> [ :nodes | nodes inputValue allButFirst asSymbol ]
]

{ #category : #'as yet unclassified' }
CssParser >> convertPropertyName: aString [
	| strParts result |
	strParts := aString substrings: '-'.
	result := strParts first.
	strParts allButFirstDo: [ :str | result := result , str asCamelCase ].
	^ result
]

{ #category : #'as yet unclassified' }
CssParser >> createSimpleSelector: anItem [
	| theSelector |
	theSelector := CssSimpleSelector new
		name: anItem first first;
		id: anItem first second;
		yourself.
	theSelector styleClasses addAll: anItem first third.
	theSelector pseudoClasses addAll: anItem second.
	^ theSelector
		update;
		yourself
]

{ #category : #'grammar declaration' }
CssParser >> declaration [
	^ super declaration
		==>
			[ :nodes | 
			nodes first = #transition
				ifTrue:
					[ CssTransitionDeclaration new
						property: nodes third value first;
						duration: nodes third value second;
						timingFunction: (nodes third value at: 3 ifAbsent: [ #linear ]);
						delay: (nodes third value at: 4 ifAbsent: [ 0 ]);
						yourself ]
				ifFalse:
					[ CssPropertyDeclaration new
						property: nodes first;
						value: nodes third;
						important: (nodes at: 4) isNotNil;
						yourself ] ]
]

{ #category : #'grammar declaration' }
CssParser >> declarations [
	^ super declarations ==> [ :nodes | nodes reject: [ :each | each isKindOf: PPToken ] ]
]

{ #category : #'grammar relation' }
CssParser >> descendantRelationToken [
	^ super descendantRelationToken ==> [ :nodes| CssRelation DESCENDANT ]
]

{ #category : #'grammar value' }
CssParser >> floatNumber [
	^ super floatNumber  ==> [ :nodes | Number readFrom: nodes ]
]

{ #category : #'grammar value' }
CssParser >> function [
	^ super function
		==> [ :nodes | 
			{nodes first.
			(nodes third reject: [ :item | item = $, ])} ]
]

{ #category : #'grammar value' }
CssParser >> functionToken [
	^ super functionToken
		==>
			[ :nodes | 
			| val funct args |
			val := nodes parsedValue.
			funct := val first.
			args := val second.
			(CssFunction value: funct) args: args ]
]

{ #category : #'grammar value' }
CssParser >> hexcolorToken [
	^ super hexcolorToken
		==>
			[ :nodes | CssColorValue value: (Color fromHexString: nodes inputValue allButFirst) ]
]

{ #category : #'grammar selector' }
CssParser >> idSelectorToken [
	^ super idSelectorToken ==> [ :nodes | nodes inputValue allButFirst asSymbol  ]
]

{ #category : #'grammar value' }
CssParser >> ident [
	^ super ident ==> [ :nodes | (self convertPropertyName: nodes) asSymbol ]
]

{ #category : #'grammar value' }
CssParser >> identToken [
	^ super identToken
		==>
			[ :nodes | 
			| val |
			val := nodes parsedValue.
			(Color respondsTo: val)
				ifTrue: [ CssColorValue value: (Color perform: val) ]
				ifFalse: [ CssSymbolValue value: val ] ]
]

{ #category : #'grammar value' }
CssParser >> intNumber [
	^ super intNumber  ==> [ :nodes | Number readFrom: nodes ]
]

{ #category : #'grammar value' }
CssParser >> listToken [
	^ super listToken
		==>
			[ :nodes | CssArrayValue value: (nodes withIndexSelect: [ :e :i | i odd]) ]
]

{ #category : #'grammar media' }
CssParser >> media [
	^ super media
		==>
			[ :nodes | 
			CssMedia new
				conditions: nodes second first first;
				rules: nodes second third asOrderedCollection;
				yourself ]
]

{ #category : #'grammar media' }
CssParser >> mediaCondition [
	^ super mediaCondition ==> [ :nodes | nodes second -> (nodes at: 4) ]
]

{ #category : #'grammar media' }
CssParser >> mediaConditions [
	^ super mediaConditions ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asDictionary ]
]

{ #category : #'grammar media' }
CssParser >> mediaDefaultTypeWithConditions [
	^ super mediaDefaultTypeWithConditions
		==> [ :nodes | 
			CssMediaCondition new
				type: #default;
				conditions: nodes;
				yourself ]
]

{ #category : #'grammar media' }
CssParser >> mediaQuery [
	^ super mediaQuery ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection ]
]

{ #category : #'grammar media' }
CssParser >> mediaTypeToken [
	^ super mediaTypeToken ==> [ :nodes | nodes asSymbol ]
]

{ #category : #'grammar media' }
CssParser >> mediaTypeWithConditions [
	^ super mediaTypeWithConditions
		==> [ :nodes | 
			CssMediaCondition new
				type: nodes first;
				conditions: nodes second second;
				yourself ]
]

{ #category : #'grammar selector' }
CssParser >> nameSelectorToken [
	^ super nameSelectorToken ==> [ :nodes | nodes inputValue asSymbol ]
]

{ #category : #'grammar value' }
CssParser >> numberToken [
	^ super numberToken ==> [ :nodes | CssNumberValue value value: nodes parsedValue ]
]

{ #category : #'grammar value' }
CssParser >> percentSymbol [
	^ super percentSymbol ==> [ :nodes | 'percent' ]
]

{ #category : #'grammar declaration' }
CssParser >> propertyToken [
	^ super propertyToken ==> [ :nodes | nodes parsedValue ]
]

{ #category : #'grammar selector' }
CssParser >> pseudoClassSelectorToken [
	^ super pseudoClassSelectorToken
		==> [ :nodes | nodes inputValue allButFirst asSymbol ]
]

{ #category : #grammar }
CssParser >> rule [
	^ super rule
		==> [ :nodes | | collection |
			collection := nodes third ifNil: [ OrderedCollection new ].
			CssRule new
				selectors: nodes first;
				declarations: collection;
				yourself ]
]

{ #category : #'grammar selector' }
CssParser >> selector [
	^ super selector
		==>
			[ :nodes | 
			| finalSelector theSelectors theRelations |
			theSelectors := OrderedCollection new.
			theRelations := OrderedCollection new.
			nodes
				withIndexDo:
					[ :item :index | 
					index % 2 = 1
						ifTrue: [ theSelectors add: (self createSimpleSelector: item) ]
						ifFalse: [ theRelations add: item ] ].
			theSelectors size = 1
				ifTrue: [ finalSelector := theSelectors first ]
				ifFalse:
					[ finalSelector := CssCompoundSelector new
						selectors: theSelectors;
						relationships: theRelations;
						update;
						yourself ].
			finalSelector ]
]

{ #category : #'grammar selector' }
CssParser >> selectors [
  ^ super selectors ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection   ]
]

{ #category : #'grammar value' }
CssParser >> string [
	^ super string ==> [ :nodes | nodes second ]
]

{ #category : #'grammar value' }
CssParser >> stringToken [
	^ super stringToken ==> [ :nodes | CssStringValue value value: nodes parsedValue ]
]

{ #category : #grammar }
CssParser >> stylesheet [
	^ super stylesheet
		==> [ :nodes | 
			| ss |
			ss := CssStylesheet new.
			nodes do: [ :item | item addTo: ss ].
			ss ]
]

{ #category : #'grammar value' }
CssParser >> typedValue [
	^ super typedValue
		==>
			[ :nodes | 
			CssValue
				perform: nodes parsedValue second asSymbol asMutator
				with: nodes parsedValue first ]
]
