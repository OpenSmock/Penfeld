"
A PenBlocImageDresserTest is a test class for testing the behavior of PenBlocImageDresser
"
Class {
	#name : #PenBlocImageDresserTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Bloc-Tests-Dressers'
}

{ #category : #running }
PenBlocImageDresserTest >> setUp [ 
	"Refresh style"
	PenDefaultStylesheet current
]

{ #category : #tests }
PenBlocImageDresserTest >> testBuild [ 
	<PenExample>
	| image |
	self flag: 'Not the best way to find Pharo logo'.
	image := PenImage new
		form: ImageReadWriterTest new pharoLogoForm;
		dresser: PenBlocImageDresser new;
		build.
	^ image engineElement.
	
]
