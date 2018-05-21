Pod::Spec.new do |s|
  s.name = 'ConsentKit'
  s.version = '0.9'
  s.summary = 'Keep track of GDPR consents in your app.'
  s.description = <<-DESC
   Keep track of GDPR consents in your app.
 DESC
  s.module_name = "ConsentKit"
  s.homepage = 'https://github.com/ralcr/Consent'
  s.license = 'MIT'
  s.authors = { 'Cristian Baluta' => 'cristi.baluta@gmail.com' }
  s.ios.deployment_target = '10.0'
  s.source = { :git => 'https://github.com/ralcr/Consent', :tag => s.version }
  s.source_files = 'src/*.{h,swift}'
end
