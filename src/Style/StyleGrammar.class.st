Class {
	#name : #StyleGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'stylesheet',
		'declarations',
		'declaration',
		'rule',
		'ident',
		'integer',
		'float',
		'number',
		'quotesString',
		'doubleQuotesString',
		'hexColor3',
		'hexColor6',
		'comment',
		'function',
		'identToken',
		'numberToken',
		'stringToken',
		'hexColorToken',
		'atKeywordToken',
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
		'functionArgs',
		'arrayToken',
		'listToken',
		'baseValue',
		'percentToken',
		'lengthToken',
		'fontSizeToken',
		'typedValue',
		'baseClassSelector',
		'baseIdSelector',
		'baseNameSelector',
		'importantIdent',
		'durationToken',
		'media',
		'mediaCondition',
		'mediaTypeToken',
		'mediaPropertyToken',
		'mediaQuery',
		'mediaAndToken',
		'mediaSeparatorToken',
		'mediaConditions',
		'mediaTypeWithConditions',
		'percentSymbol'
	],
	#category : #'Style-Utils'
}

{ #category : #'as yet unclassified' }
StyleGrammar class >> parseSelectors: anObject [
	^ self parse: anObject startingAt: #startSelectors
]

{ #category : #tokens }
StyleGrammar >> arrayToken [
	^ baseValue min: 2
]

{ #category : #tokens }
StyleGrammar >> atKeywordToken [
	^ ($@ asParser , ident) token trim
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
	^ (typedValue / numberToken / function / stringToken / identToken / hexColorToken ) trim
]

{ #category : #'grammar relation' }
StyleGrammar >> childRelationToken [
	^ $> asParser trim token
]

{ #category : #'grammar selector' }
StyleGrammar >> classSelectorToken [
	^ ($. asParser , ident) token
]

{ #category : #primitives }
StyleGrammar >> comment [
	^ '/*' asParser , PPPredicateObjectParser any , '*/' asParser
]

{ #category : #'grammar declaration' }
StyleGrammar >> declaration [
  ^ identToken, $: asParser trim, propertyValue, importantIdent optional
]

{ #category : #'grammar declaration' }
StyleGrammar >> declarations [
	^ declaration delimitedBy: $; asParser trim token
]

{ #category : #'grammar relation' }
StyleGrammar >> descendantRelationToken [
	^ #space asParser token
]

{ #category : #primitives }
StyleGrammar >> doubleQuotesString [
	^ $" asParser , (PPPredicateObjectParser anyExceptAnyOf: '"') star flatten , $" asParser
]

{ #category : #tokens }
StyleGrammar >> durationToken [
	^ (number , ('s' asParser / 'ms' asParser)) token
]

{ #category : #primitives }
StyleGrammar >> float [
	^ ($- asParser optional , ($0 asParser / #digit asParser plus)
		, ($. asParser , ($0 asParser / #digit asParser plus))) flatten
]

{ #category : #tokens }
StyleGrammar >> fontSizeToken [
	^ ((integer , 'pt' asParser) / (number , 'em' asParser) / (number , 'rem' asParser)) token
]

{ #category : #'grammar value' }
StyleGrammar >> function [
	^ ident, $( asParser , (functionArgs separatedBy: $, asParser) , $) asParser
]

{ #category : #'grammar value' }
StyleGrammar >> functionArgs [
	^ arrayToken / baseValue
]

{ #category : #primitives }
StyleGrammar >> hexColor3 [
	^ $# asParser , (PPPredicateObjectParser hex times: 3)
]

{ #category : #primitives }
StyleGrammar >> hexColor6 [
	^ $# asParser , (PPPredicateObjectParser hex times: 6) flatten.
]

{ #category : #tokens }
StyleGrammar >> hexColorToken [
	^ (hexColor6 / hexColor3) token
]

{ #category : #'grammar selector' }
StyleGrammar >> idSelectorToken [
	^ ($# asParser , #word asParser plus) token
]

{ #category : #primitives }
StyleGrammar >> ident [
	^ ($- asParser optional, #letter asParser, ($- asParser / #word asParser) star) flatten
]

{ #category : #tokens }
StyleGrammar >> identToken [
	^ ident token
]

{ #category : #'grammar declaration' }
StyleGrammar >> importantIdent [
	^ ($! asParser trim , 'important' asParser) flatten
]

{ #category : #primitives }
StyleGrammar >> integer [
	^ ($- asParser optional , ($0 asParser / #digit asParser plus)) flatten
]

{ #category : #tokens }
StyleGrammar >> lengthToken [
	^ (number , 'px' asParser) token
]

{ #category : #tokens }
StyleGrammar >> listToken [
	^ baseValue trim, ($, asParser trim, baseValue trim) plus
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

{ #category : #primitives }
StyleGrammar >> number [
	^ float / integer
]

{ #category : #tokens }
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

{ #category : #primitives }
StyleGrammar >> percentSymbol [
	^ '%' asParser
]

{ #category : #tokens }
StyleGrammar >> percentToken [
	^ (integer , percentSymbol) token
]

{ #category : #'grammar declaration' }
StyleGrammar >> propertyToken [
	^ ident token
]

{ #category : #'grammar value' }
StyleGrammar >> propertyValue [
	^ listToken / arrayToken / baseValue
]

{ #category : #'grammar selector' }
StyleGrammar >> pseudoClassSelectorToken [
	^ $: asParser, ident, ($( asParser, (integer / ident), $) asParser) optional
]

{ #category : #primitives }
StyleGrammar >> quotesString [
	^ $' asParser , PPPredicateObjectParser any star , $' asParser
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

{ #category : #tokens }
StyleGrammar >> stringToken [
	^ (quotesString / doubleQuotesString) token
]

{ #category : #grammar }
StyleGrammar >> stylesheet [
	^ (rule / media) plus
]

{ #category : #'grammar value' }
StyleGrammar >> typedValue [
	^ percentToken / lengthToken / fontSizeToken / durationToken
]
