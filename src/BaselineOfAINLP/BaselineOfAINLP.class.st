Class {
	#name : #BaselineOfAINLP,
	#superclass : #BaselineOf,
	#category : #BaselineOfAINLP
}

{ #category : #baselines }
BaselineOfAINLP >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			"External dependencies"
			spec
				baseline: 'AIStopwords'
				with: [ spec repository: 'github://pharo-ai/stopwords/src' ].

			"Packages"
				spec 
					package: 'AI-NLP'					with: [ spec requires: #('AIStopwords') ];
					package: 'AI-NLP-Tests'			with: [ spec requires: #('AI-NLP') ].
		
				spec
					group: 'Core' 						with: #('AI-NLP');
					group: 'Tests' 						with: #('AI-NLP' 'AI-NLP-Tests');
					group: 'default' 					with: #('	Tests') ]
]
