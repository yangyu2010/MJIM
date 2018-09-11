#
# Be sure to run `pod lib lint MJIM.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MJIM'
  s.version          = '0.1.0'
  s.summary          = '聊天相关的'

  s.homepage         = 'https://github.com/yangyu2010/MJIM'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yu Yang' => 'yangyu2010@aliyun.com' }
  s.source           = { :git => 'https://github.com/yangyu2010/MJIM.git', :tag => "v-#{s.version}" }

  s.ios.deployment_target = '9.0'
  s.default_subspec = 'Socket'

  #s.source_files = 'MJIM/Classes/**/*'
  #s.dependency 'SocketRocket'
  #s.dependency 'MJWebService'
  #s.dependency 'DBModel/DBManager'
  
  s.subspec 'Socket' do |ss|
      ss.source_files = 'MJIM/Classes/Socket/*'
      ss.dependency 'SocketRocket'
      ss.dependency 'MJWebService'
  end
  
  s.subspec 'Models' do |ss|
      ss.source_files = 'MJIM/Classes/Models/**/*'
      ss.dependency 'DBModel/DBManager'
      ss.dependency 'ModuleCapability'
  end
  

end
