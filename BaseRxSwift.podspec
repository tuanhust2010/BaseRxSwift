Pod::Spec.new do |s|
s.name = 'BaseRxSwift'
s.version = '0.1.1'
s.summary = 'The Base Library'
s.description = <<-DESC
The Base Library for RxSwift
DESC

s.homepage = 'https://github.com/tuanhust2010/BaseRxSwift'
s.license = { type: 'MIT', file: 'LICENSE' }
s.authors = { 'Tuan nguyen' => 'tuanhust2010@gmail.com' }


s.ios.deployment_target = '10.0'

s.swift_version = '4.2'
s.source = { git: 'https://github.com/tuanhust2010/BaseRxSwift.git', tag: s.version.to_s }
s.source_files = 'BaseRxSwift/Base/*.swift'

s.dependency 'RxSwift'
s.dependency 'RxCocoa'
s.dependency 'NVActivityIndicatorView'

end
