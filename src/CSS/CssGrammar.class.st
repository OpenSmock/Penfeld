Class {
	#name : #CssGrammar,
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
	#category : #'CSS-Utils'
}

{ #category : #'as yet unclassified' }
CssGrammar class >> parseSelectors: anObject [
	^ self parse: anObject startingAt: #startSelectors
]

{ #category : #'grammar value' }
CssGrammar >> array [
	^ (baseValue min: 2) separatedBy: #space asParser
]

{ #category : #'grammar value' }
CssGrammar >> arrayToken [
	^ array token
]

{ #category : #'grammar selector' }
CssGrammar >> baseClassSelector [
	^ nameSelectorToken optional , idSelectorToken optional , classSelectorToken plus
]

{ #category : #'grammar selector' }
CssGrammar >> baseIdSelector [
	^ nameSelectorToken optional, idSelectorToken , classSelectorToken star
]

{ #category : #'grammar selector' }
CssGrammar >> baseNameSelector [
	^ nameSelectorToken, idSelectorToken optional, classSelectorToken star
]

{ #category : #'grammar value' }
CssGrammar >> baseValue [
	^ (typedValue / numberToken / functionToken / stringToken / identToken / hexcolorToken ) trim
]

{ #category : #'grammar relation' }
CssGrammar >> childRelationToken [
	^ $> asParser trim token
]

{ #category : #'grammar selector' }
CssGrammar >> classSelectorToken [
	^ ($. asParser , ident) token
]

{ #category : #'grammar declaration' }
CssGrammar >> declaration [
  ^ (propertyToken , $: asParser trim , propertyValue, importantIdent optional) trim
]

{ #category : #'grammar declaration' }
CssGrammar >> declarations [
	^ declaration delimitedBy: $; asParser trim token
]

{ #category : #'grammar relation' }
CssGrammar >> descendantRelationToken [
	^ #space asParser token
]

{ #category : #'grammar value' }
CssGrammar >> durationToken [
	^ (number , ('s' asParser / 'ms' asParser)) token
]

{ #category : #'grammar value' }
CssGrammar >> floatNumber [
	^ ($- asParser optional , ($0 asParser / #digit asParser plus)
		, ($. asParser , ($0 asParser / #digit asParser plus))) flatten
]

{ #category : #'grammar value' }
CssGrammar >> fontSize [
	^ (intNumber , 'pt' asParser) / (number , 'em' asParser) / (number , 'rem' asParser)
]

{ #category : #'grammar value' }
CssGrammar >> fontSizeToken [
	^ fontSize token
]

{ #category : #'grammar value' }
CssGrammar >> function [
	^ ident , $( asParser , (functionArgs separatedBy: $, asParser) , $) asParser
]

{ #category : #'grammar value' }
CssGrammar >> functionArgs [
	^ array / baseValue
]

{ #category : #'grammar value' }
CssGrammar >> functionToken [
	^ function token
]

{ #category : #'grammar value' }
CssGrammar >> hexcolor [
	^ $# asParser , (#word asParser times: 6) flatten
]

{ #category : #'grammar value' }
CssGrammar >> hexcolorToken [
	^ hexcolor token
]

{ #category : #'grammar selector' }
CssGrammar >> idSelectorToken [
	^ ($# asParser , #word asParser plus) token
]

{ #category : #'grammar value' }
CssGrammar >> ident [
	^ (#word asParser / $- asParser) plus flatten
]

{ #category : #'grammar value' }
CssGrammar >> identToken [
	^ ident token
]

{ #category : #'grammar declaration' }
CssGrammar >> importantIdent [
	^ ($! asParser trim , 'important' asParser) flatten
]

{ #category : #'grammar value' }
CssGrammar >> intNumber [
	^ ($- asParser optional , ($0 asParser / #digit asParser plus)) flatten
]

{ #category : #'grammar value' }
CssGrammar >> lengthToken [
	^ (intNumber , 'px' asParser) token
]

{ #category : #'grammar value' }
CssGrammar >> listToken [
	^ stringToken separatedBy: $, asParser token trim 
]

{ #category : #'grammar media' }
CssGrammar >> media [
	^ '@media' asParser trim , ((mediaQuery separatedBy: mediaSeparatorToken) , ${ asParser trim , rule star , $} asParser) trim
]

{ #category : #'grammar media' }
CssGrammar >> mediaAndToken [
	^ 'and' asParser trim token
]

{ #category : #'grammar media' }
CssGrammar >> mediaCondition [
	^ $( asParser trim , mediaPropertyToken , $: asParser trim , propertyValue optional , $) asParser trim
]

{ #category : #'grammar media' }
CssGrammar >> mediaConditions [
	^ mediaCondition separatedBy: mediaAndToken
]

{ #category : #'grammar media' }
CssGrammar >> mediaPropertyToken [
	^ propertyToken
]

{ #category : #'grammar media' }
CssGrammar >> mediaQuery [
	^ mediaConditions / mediaTypeWithConditions separatedBy: mediaSeparatorToken
]

{ #category : #'grammar media' }
CssGrammar >> mediaSeparatorToken [
	^ $, asParser trim token
]

{ #category : #'grammar media' }
CssGrammar >> mediaTypeToken [
	^ propertyToken 
]

{ #category : #'grammar media' }
CssGrammar >> mediaTypeWithConditions [
	^ mediaTypeToken , (mediaAndToken , mediaConditions) optional
]

{ #category : #'grammar selector' }
CssGrammar >> nameSelectorToken [
	^ (#word asParser plus / $* asParser) token
	
]

{ #category : #'grammar value' }
CssGrammar >> number [
	^ (floatNumber / intNumber ) trim
]

{ #category : #'grammar value' }
CssGrammar >> numberToken [
	^ number token
]

{ #category : #'grammar relation' }
CssGrammar >> orRelationToken [
	^ $, asParser trim token
]

{ #category : #'grammar relation' }
CssGrammar >> parentRelation [
	^ childRelationToken / descendantRelationToken
]

{ #category : #'grammar value' }
CssGrammar >> percentSymbol [
	^   '%' asParser
]

{ #category : #'grammar value' }
CssGrammar >> percentToken [
	^ (intNumber , percentSymbol) token
]

{ #category : #'grammar declaration' }
CssGrammar >> propertyToken [
	^ ident token
]

{ #category : #'grammar value' }
CssGrammar >> propertyValue [
	^ (listToken / arrayToken / baseValue) trim
]

{ #category : #'grammar selector' }
CssGrammar >> pseudoClassSelectorToken [
	^ ($: asParser , #word asParser plus) token
]

{ #category : #grammar }
CssGrammar >> root [
  ^ rule plus
]

{ #category : #grammar }
CssGrammar >> rule [
 ^ (selectors, ${ asParser trim , declarations optional , $} asParser) trim
]

{ #category : #'grammar selector' }
CssGrammar >> selector [
	^ baseClassSelector / baseIdSelector / baseNameSelector , pseudoClassSelectorToken star separatedBy: parentRelation
]

{ #category : #'grammar selector' }
CssGrammar >> selectors [
  ^ selector separatedBy:orRelationToken
]

{ #category : #grammar }
CssGrammar >> start [
	^ stylesheet end
]

{ #category : #grammar }
CssGrammar >> startSelectors [
	^ selectors end
]

{ #category : #'grammar value' }
CssGrammar >> string [
	^ $" asParser,
		(#letter asParser plus , ((#space asParser / $- asParser) , #letter asParser plus) star) flatten, 
		$" asParser
]

{ #category : #'grammar value' }
CssGrammar >> stringToken [
	^ string token
]

{ #category : #grammar }
CssGrammar >> stylesheet [
	^ (rule / media) plus
]

{ #category : #'grammar value' }
CssGrammar >> typedValue [
	^ percentToken / lengthToken / fontSizeToken / durationToken
]
