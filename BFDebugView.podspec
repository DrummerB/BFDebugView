Pod::Spec.new do |spec|
  spec.name = 'BFDebugView'
  spec.version = '1.0.0'
  spec.authors = {'Balázs Faludi' => 'balazsfaludi@gmail.com'}
  spec.homepage = 'https://github.com/DrummerB/BFDebugView'
  spec.summary = 'A simple view that draws a grid for layout debugging purposes.'

  spec.platform = :ios
  spec.requires_arc = true

  spec.source = {:git => 'https://github.com/DrummerB/BFDebugView.git', :tag => spec.version.to_s}
  spec.source_files = 'BFDebugView/**/*.{h,m}'
end
