Pod::Spec.new do |s|
  s.name = 'CPFExtension'
  s.version = '1.1.4'
  s.summary = 'Swift一些实用扩展'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'chenpengfei' => 'afeiafeia@163.com' }
  s.source = { :git => 'https://github.com/Loadar/CPFExtension.git', :tag => s.version.to_s }
  s.homepage = 'https://github.com/Loadar/CPFExtension'

  s.ios.deployment_target = "8.0"
  s.source_files = 'Sources/CPFExtension/*.swift', 'Sources/CPFExtension/*/*.swift'
  s.requires_arc = true
  s.dependency 'CPFChain'
end
