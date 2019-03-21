Class {
	#name : #StyleParser,
	#superclass : #StyleGrammar,
	#category : #'Style-Utils'
}

{ #category : #'grammar value' }
StyleParser >> arrayToken [
	^ super arrayToken
		==>
			[ :nodes | StyleArrayValue value: (nodes parsedValue first collect: [ :item | item value ]) ]
]

{ #category : #'grammar relation' }
StyleParser >> childRelationToken [
	^ super childRelationToken ==> [ :nodes| StyleRelation CHILD ]
]

{ #category : #'grammar selector' }
StyleParser >> classSelectorToken [
	^ super classSelectorToken ==> [ :nodes | nodes inputValue allButFirst asSymbol ]
]

{ #category : #'as yet unclassified' }
StyleParser >> convertPropertyName: aString [
	| strParts result |
	strParts := aString substrings: '-'.
	result := strParts first.
	strParts allButFirstDo: [ :str | result := result , str asCamelCase ].
	^ result
]

{ #category : #'as yet unclassified' }
StyleParser >> createSimpleSelector: anItem [
	| theSelector |
	theSelector := StyleSimpleSelector new
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
StyleParser >> declaration [
	^ super declaration
		==>
			[ :nodes | 
			nodes first = #transition
				ifTrue:
					[ StyleTransitionDeclaration new
						property: nodes third value first;
						duration: nodes third value second;
						timingFunction: (nodes third value at: 3 ifAbsent: [ #linear ]);
						delay: (nodes third value at: 4 ifAbsent: [ 0 ]);
						yourself ]
				ifFalse:
					[ StylePropertyDeclaration new
						property: nodes first;
						value: nodes third;
						important: (nodes at: 4) isNotNil;
						yourself ] ]
]

{ #category : #'grammar declaration' }
StyleParser >> declarations [
	^ super declarations ==> [ :nodes | nodes reject: [ :each | each isKindOf: PPToken ] ]
]

{ #category : #'grammar relation' }
StyleParser >> descendantRelationToken [
	^ super descendantRelationToken ==> [ :nodes| StyleRelation DESCENDANT ]
]

{ #category : #'grammar value' }
StyleParser >> floatNumber [
	^ super floatNumber  ==> [ :nodes | Number readFrom: nodes ]
]

{ #category : #'grammar value' }
StyleParser >> function [
	^ super function
		==> [ :nodes | 
			{nodes first.
			(nodes third reject: [ :item | item = $, ])} ]
]

{ #category : #'grammar value' }
StyleParser >> functionToken [
	^ super functionToken
		==>
			[ :nodes | 
			| val funct args |
			val := nodes parsedValue.
			funct := val first.
			args := val second.
			(StyleFunction value: funct) args: args ]
]

{ #category : #'grammar value' }
StyleParser >> hexcolorToken [
	^ super hexcolorToken
		==>
			[ :nodes | StyleColorValue value: (Color fromHexString: nodes inputValue allButFirst) ]
]

{ #category : #'grammar selector' }
StyleParser >> idSelectorToken [
	^ super idSelectorToken ==> [ :nodes | nodes inputValue allButFirst asSymbol  ]
]

{ #category : #'grammar value' }
StyleParser >> ident [
	^ super ident ==> [ :nodes | (self convertPropertyName: nodes) asSymbol ]
]

{ #category : #'grammar value' }
StyleParser >> identToken [
	^ super identToken
		==>
			[ :nodes | 
			| val |
			val := nodes parsedValue.
			(Color respondsTo: val)
				ifTrue: [ StyleColorValue value: (Color perform: val) ]
				ifFalse: [ StyleSymbolValue value: val ] ]
]

{ #category : #'grammar value' }
StyleParser >> intNumber [
	^ super intNumber  ==> [ :nodes | Number readFrom: nodes ]
]

{ #category : #'grammar value' }
StyleParser >> listToken [
	^ super listToken
		==>
			[ :nodes | StyleArrayValue value: (nodes withIndexSelect: [ :e :i | i odd]) ]
]

{ #category : #'grammar media' }
StyleParser >> media [
	^ super media
		==>
			[ :nodes | 
			StyleMedia new
				conditions: nodes second first first;
				rules: nodes second third asOrderedCollection;
				yourself ]
]

{ #category : #'grammar media' }
StyleParser >> mediaCondition [
	^ super mediaCondition ==> [ :nodes | nodes second -> (nodes at: 4) ]
]

{ #category : #'grammar media' }
StyleParser >> mediaConditions [
	^ super mediaConditions ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asDictionary ]
]

{ #category : #'grammar media' }
StyleParser >> mediaDefaultTypeWithConditions [
	^ super mediaDefaultTypeWithConditions
		==> [ :nodes | 
			StyleMediaCondition new
				type: #default;
				conditions: nodes;
				yourself ]
]

{ #category : #'grammar media' }
StyleParser >> mediaQuery [
	^ super mediaQuery ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection ]
]

{ #category : #'grammar media' }
StyleParser >> mediaTypeToken [
	^ super mediaTypeToken ==> [ :nodes | nodes asSymbol ]
]

{ #category : #'grammar media' }
StyleParser >> mediaTypeWithConditions [
	^ super mediaTypeWithConditions
		==> [ :nodes | 
			StyleMediaCondition new
				type: nodes first;
				conditions: nodes second second;
				yourself ]
]

{ #category : #'grammar selector' }
StyleParser >> nameSelectorToken [
	^ super nameSelectorToken ==> [ :nodes | nodes inputValue asSymbol ]
]

{ #category : #'grammar value' }
StyleParser >> numberToken [
	^ super numberToken ==> [ :nodes | StyleNumberValue value value: nodes parsedValue ]
]

{ #category : #'grammar value' }
StyleParser >> percentSymbol [
	^ super percentSymbol ==> [ :nodes | 'percent' ]
]

{ #category : #'grammar declaration' }
StyleParser >> propertyToken [
	^ super propertyToken ==> [ :nodes | nodes parsedValue ]
]

{ #category : #'grammar selector' }
StyleParser >> pseudoClassSelectorToken [
	^ super pseudoClassSelectorToken
		==> [ :nodes | nodes inputValue allButFirst asSymbol ]
]

{ #category : #grammar }
StyleParser >> rule [
	^ super rule
		==> [ :nodes | | collection |
			collection := nodes third ifNil: [ OrderedCollection new ].
			StyleRule new
				selectors: nodes first;
				declarations: collection;
				yourself ]
]

{ #category : #'grammar selector' }
StyleParser >> selector [
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
					[ finalSelector := StyleCompoundSelector new
						selectors: theSelectors;
						relationships: theRelations;
						update;
						yourself ].
			finalSelector ]
]

{ #category : #'grammar selector' }
StyleParser >> selectors [
  ^ super selectors ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection   ]
]

{ #category : #'grammar value' }
StyleParser >> string [
	^ super string ==> [ :nodes | nodes second ]
]

{ #category : #'grammar value' }
StyleParser >> stringToken [
	^ super stringToken ==> [ :nodes | StyleStringValue value value: nodes parsedValue ]
]

{ #category : #grammar }
StyleParser >> stylesheet [
	^ super stylesheet
		==> [ :nodes | 
			| ss |
			ss := StyleStylesheet new.
			nodes do: [ :item | item addTo: ss ].
			ss ]
]

{ #category : #'grammar value' }
StyleParser >> typedValue [
	^ super typedValue
		==>
			[ :nodes | 
			StyleValue
				perform: nodes parsedValue second asSymbol asMutator
				with: nodes parsedValue first ]
]
