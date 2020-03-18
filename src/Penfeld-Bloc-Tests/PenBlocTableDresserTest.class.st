Class {
	#name : #PenBlocTableDresserTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Bloc-Tests-Dressers'
}

{ #category : #accessing }
PenBlocTableDresserTest >> allSubclasses: aClass [
	| list |
	list := OrderedCollection new.
	aClass
		withAllSubclassesDo: [ :class | 
			| row |
			row := PenTableItem new.
			row key: class name asSymbol.
			row dresser: PenBlocTableItemDresser new.
			row atSection: #name put: (PenLabel text: class name).
			row
				atSection: #numberOfSubclasses
				put: (PenLabel text: class subclasses size printString).
			row
				atSection: #numberOfVariables
				put: (PenLabel text: class instVarNames size printString).
			list add: row ].
	^ list
]

{ #category : #accessing }
PenBlocTableDresserTest >> header [
	^ PenTableItem new
		dresser: PenBlocTableItemHeaderDresser new;
		atSection: #name put: (PenLabel new text: 'Nom');
		atSection: #numberOfSubclasses put: (PenLabel new text: 'Sub.');
		atSection: #numberOfVariables put: (PenLabel new text: 'Inst.');
		yourself
	
]

{ #category : #running }
PenBlocTableDresserTest >> setUp [ 
	"Refresh style"
	PenDefaultStylesheet current
]

{ #category : #tests }
PenBlocTableDresserTest >> testBuild [
	<PenExample>
	| cmp element |
	cmp := PenTable new
		sections: { 
			PenSection new selector: #name.
			PenSection new selector: #numberOfSubclasses; size: 40.
			PenSection new selector: #numberOfVariables; size: 40 };
		header: self header;
		addAllItems: (self allSubclasses: PenComponent);
		dresser: PenBlocTableDresser new.
	element := cmp engineElement.
	element forceLayout.
	
	^ element
]
