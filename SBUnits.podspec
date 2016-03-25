Pod::Spec.new do |s|
  s.name     = 'SBUnits'
  s.version  = '0.1.0'
  s.summary  = 'Dimensions, Units and Quantities'
  s.description = <<-DESC
A number without its unit of measure is meaningless at best and dangerous at worst. The unit
provides the context within which to interpret the value...
DESC

  s.homepage = 'http://github.com/EBGToo/SBUnits'

  s.license  = 'MIT'
  s.authors  = { 'Ed Gamble' => 'ebg@opuslogica.com' }
  s.source   = { :git => 'https://github.com/EBGToo/SBUnits.git',
                 :tag => s.version }
  s.source_files = 'Sources/*.swift'

  s.osx.deployment_target = '10.9'
end
