Pod::Spec.new do |s|
  s.name             = 'InoMvvmc'
  s.version          = '0.1.0'
  s.summary          = 'Base classes for MVVM+C modules.'
 
  s.description      = <<-DESC
This pod contains basic classes required to start working with MVVM+C architecture.
                       DESC
 
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yaroslav Magin' => 'y.magin@inostudio.com' }
  s.homepage         = 'https://inostudio.com'
  s.source           = { :git => '' }
 
  s.ios.deployment_target = '11.0'
  s.source_files = '**/*.swift'

  s.dependency 'RxSwift'
  s.dependency 'Swinject'
 
end