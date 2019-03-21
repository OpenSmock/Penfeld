Class {
	#name : #StyleGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'parentRelation',
		'orRelationToken',
		'childRelationToken',
		'descendantRelationToken',
		'selectors',
		'selector',
		'nameSelectorToken',
		'idSelectorToken',
		'classSelectorToken',
		'pseudoClassSelectorToken',
		'propertyToken',
		'propertyValue',
		'declarations',
		'declaration',
		'numberToken',
		'percentToken',
		'lengthToken',
		'stringToken',
		'identToken',
		'hexcolorToken',
		'number',
		'string',
		'ident',
		'hexcolor',
		'rule',
		'fontSize',
		'fontSizeToken',
		'intNumber',
		'floatNumber',
		'array',
		'arrayToken',
		'baseValue',
		'typedValue',
		'percentSymbol',
		'baseClassSelector',
		'baseIdSelector',
		'baseNameSelector',
		'importantIdent',
		'durationToken',
		'stylesheet',
		'function',
		'functionToken',
		'media',
		'mediaCondition',
		'mediaTypeToken',
		'mediaPropertyToken',
		'mediaQuery',
		'mediaAndToken',
		'mediaSeparatorToken',
		'mediaConditions',
		'mediaTypeWithConditions',
		'listToken',
		'functionArgs'
	],
	#category : #'Style-Utils'
}

{ #category : #'as yet unclassified' }
StyleGrammar class >> parseSelectors: anObject [
	^ self parse: anObject startingAt: #startSelectors
]

{ #category : #'grammar value' }
StyleGrammar >> array [
	^ (baseValue min: 2) separatedBy: #space asParser
]

{ #category : #'grammar value' }
StyleGrammar >> arrayToken [
	^ array token
]

{ #category : #'grammar selector' }
StyleGrammar >> baseClassSelector [
	^ nameSelectorToken optional , idSelectorToken optional , classSelectorToken plus
]

{ #category : #'grammar selector' }
StyleGrammar >> baseIdSelector [
	^ nameSelectorToken optional, idSelectorToken , classSelectorToken star
]

{ #category : #'grammar selector' }
StyleGrammar >> baseNameSelector [
	^ nameSelectorToken, idSelectorToken optional, classSelectorToken star
]

{ #category : #'grammar value' }
StyleGrammar >> baseValue [
	^ (typedValue / numberToken / functionToken / stringToken / identToken / hexcolorToken ) trim
]

{ #category : #'grammar relation' }
StyleGrammar >> childRelationToken [
	^ $> asParser trim token
]

{ #category : #'grammar selector' }
StyleGrammar >> classSelectorToken [
	^ ($. asParser , ident) token
]

{ #category : #'grammar declaration' }
StyleGrammar >> declaration [
  ^ (propertyToken , $: asParser trim , propertyValue, importantIdent optional) trim
]

{ #category : #'grammar declaration' }
StyleGrammar >> declarations [
	^ declaration delimitedBy: $; asParser trim token
]

{ #category : #'grammar relation' }
StyleGrammar >> descendantRelationToken [
	^ #space asParser token
]

{ #category : #'grammar value' }
StyleGrammar >> durationToken [
	^ (number , ('s' asParser / 'ms' asParser)) token
]

{ #category : #'grammar value' }
StyleGrammar >> floatNumber [
	^ ($- asParser optional , ($0 asParser / #digit asParser plus)
		, ($. asParser , ($0 asParser / #digit asParser plus))) flatten
]

{ #category : #'grammar value' }
StyleGrammar >> fontSize [
	^ (intNumber , 'pt' asParser) / (number , 'em' asParser) / (number , 'rem' asParser)
]

{ #category : #'grammar value' }
StyleGrammar >> fontSizeToken [
	^ fontSize token
]

{ #category : #'grammar value' }
StyleGrammar >> function [
	^ ident , $( asParser , (functionArgs separatedBy: $, asParser) , $) asParser
]

{ #category : #'grammar value' }
StyleGrammar >> functionArgs [
	^ array / baseValue
]

{ #category : #'grammar value' }
StyleGrammar >> functionToken [
	^ function token
]

{ #category : #'grammar value' }
StyleGrammar >> hexcolor [
	^ $# asParser , (#word asParser times: 6) flatten
]

{ #category : #'grammar value' }
StyleGrammar >> hexcolorToken [
	^ hexcolor token
]

{ #category : #'grammar selector' }
StyleGrammar >> idSelectorToken [
	^ ($# asParser , #word asParser plus) token
]

{ #category : #'grammar value' }
StyleGrammar >> ident [
	^ (#word asParser / $- asParser) plus flatten
]

{ #category : #'grammar value' }
StyleGrammar >> identToken [
	^ ident token
]

{ #category : #'grammar declaration' }
StyleGrammar >> importantIdent [
	^ ($! asParser trim , 'important' asParser) flatten
]

{ #category : #'grammar value' }
StyleGrammar >> intNumber [
	^ ($- asParser optional , ($0 asParser / #digit asParser plus)) flatten
]

{ #category : #'grammar value' }
StyleGrammar >> lengthToken [
	^ (intNumber , 'px' asParser) token
]

{ #category : #'grammar value' }
StyleGrammar >> listToken [
	^ stringToken separatedBy: $, asParser token trim 
]

{ #category : #'grammar media' }
StyleGrammar >> media [
	^ '@media' asParser trim , ((mediaQuery separatedBy: mediaSeparatorToken) , ${ asParser trim , rule star , $} asParser) trim
]

{ #category : #'grammar media' }
StyleGrammar >> mediaAndToken [
	^ 'and' asParser trim token
]

{ #category : #'grammar media' }
StyleGrammar >> mediaCondition [
	^ $( asParser trim , mediaPropertyToken , $: asParser trim , propertyValue optional , $) asParser trim
]

{ #category : #'grammar media' }
StyleGrammar >> mediaConditions [
	^ mediaCondition separatedBy: mediaAndToken
]

{ #category : #'grammar media' }
StyleGrammar >> mediaPropertyToken [
	^ propertyToken
]

{ #category : #'grammar media' }
StyleGrammar >> mediaQuery [
	^ mediaConditions / mediaTypeWithConditions separatedBy: mediaSeparatorToken
]

{ #category : #'grammar media' }
StyleGrammar >> mediaSeparatorToken [
	^ $, asParser trim token
]

{ #category : #'grammar media' }
StyleGrammar >> mediaTypeToken [
	^ propertyToken 
]

{ #category : #'grammar media' }
StyleGrammar >> mediaTypeWithConditions [
	^ mediaTypeToken , (mediaAndToken , mediaConditions) optional
]

{ #category : #'grammar selector' }
StyleGrammar >> nameSelectorToken [
	^ (#word asParser plus / $* asParser) token
	
]

{ #category : #'grammar value' }
StyleGrammar >> number [
	^ (floatNumber / intNumber ) trim
]

{ #category : #'grammar value' }
StyleGrammar >> numberToken [
	^ number token
]

{ #category : #'grammar relation' }
StyleGrammar >> orRelationToken [
	^ $, asParser trim token
]

{ #category : #'grammar relation' }
StyleGrammar >> parentRelation [
	^ childRelationToken / descendantRelationToken
]

{ #category : #'grammar value' }
StyleGrammar >> percentSymbol [
	^   '%' asParser
]

{ #category : #'grammar value' }
StyleGrammar >> percentToken [
	^ (intNumber , percentSymbol) token
]

{ #category : #'grammar declaration' }
StyleGrammar >> propertyToken [
	^ ident token
]

{ #category : #'grammar value' }
StyleGrammar >> propertyValue [
	^ (listToken / arrayToken / baseValue) trim
]

{ #category : #'grammar selector' }
StyleGrammar >> pseudoClassSelectorToken [
	^ ($: asParser , #word asParser plus) token
]

{ #category : #grammar }
StyleGrammar >> root [
  ^ rule plus
]

{ #category : #grammar }
StyleGrammar >> rule [
 ^ (selectors, ${ asParser trim , declarations optional , $} asParser) trim
]

{ #category : #'grammar selector' }
StyleGrammar >> selector [
	^ baseClassSelector / baseIdSelector / baseNameSelector , pseudoClassSelectorToken star separatedBy: parentRelation
]

{ #category : #'grammar selector' }
StyleGrammar >> selectors [
  ^ selector separatedBy:orRelationToken
]

{ #category : #grammar }
StyleGrammar >> start [
	^ stylesheet end
]

{ #category : #grammar }
StyleGrammar >> startSelectors [
	^ selectors end
]

{ #category : #'grammar value' }
StyleGrammar >> string [
	^ $" asParser,
		(#letter asParser plus , ((#space asParser / $- asParser) , #letter asParser plus) star) flatten, 
		$" asParser
]

{ #category : #'grammar value' }
StyleGrammar >> stringToken [
	^ string token
]

{ #category : #grammar }
StyleGrammar >> stylesheet [
	^ (rule / media) plus
]

{ #category : #'grammar value' }
StyleGrammar >> typedValue [
	^ percentToken / lengthToken / fontSizeToken / durationToken
]
