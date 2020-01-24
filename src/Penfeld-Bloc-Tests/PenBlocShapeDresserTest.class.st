"
A PenBlocShapeDresserTest is a test class for testing the behavior of PenBlocShapeDresser
"
Class {
	#name : #PenBlocShapeDresserTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Bloc-Tests-Dressers'
}

{ #category : #'tests - build geometry' }
PenBlocShapeDresserTest >> testBuildCircle [
	PenShape new shape: (GCircle center: 100 , 100 radius: 30); build.
]

{ #category : #'tests - build geometry' }
PenBlocShapeDresserTest >> testBuildEllipse [
	PenShape new shape: (GEllipse center: 40 , 10 vertex: 60 , 10 coVertex: 40 , 20); build.
]

{ #category : #'tests - build geometry' }
PenBlocShapeDresserTest >> testBuildPolygon [
	PenShape new shape: (GPolygon vertices: {(10 , 10) . (-10 , 10) . (-10 , -10)}); build.
]

{ #category : #'tests - build geometry' }
PenBlocShapeDresserTest >> testBuildRectangle [
	PenShape new shape: (GRectangle origin: 1 , 3 corner: 3 , 0); build.
]

{ #category : #'tests - build geometry' }
PenBlocShapeDresserTest >> testBuildTriangle [
	PenShape new shape: (GTriangle with: 0 , 0 with: 2 , 0 with: 0 , 2); build.
]
