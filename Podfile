#source 'git@github.com:NoryCao/cjspecs.git'
source 'https://github.com/CocoaPods/Specs.git'
#source 'https://github.com/sinaweibosdk/weibo_ios_sdk.git'

# 对于Swift应用来说下面两句是必须的
platform :ios, '9.0'
#use_frameworks!
branch = ENV['sha']

# target的名字一般与你的项目名字相同
target 'zhuishushenqi' do
project './zhuishushenqi.xcodeproj'

pod 'YYText'
pod 'YYModel'
pod 'YYImage'
pod 'MBProgressHUD'
pod 'MJRefresh'
pod 'CocoaAsyncSocket'
pod 'CocoaLumberjack', '3.4.2'
pod 'YYCategories'
pod 'FMDB'
#pod 'WechatOpenSDK'
#pod 'Weibo_SDK'

# local pods
#pod 'ZSThirdPartSDK', :path => "zhuishushenqi/NewVersion/ZSThirdPartSDK"
#pod 'ZSBookShelf', :path => "zhuishushenqi/NewVersion/ZSBookShelf"
#pod 'ZSBookStore', :path => "zhuishushenqi/NewVersion/ZSBookStore"
#pod 'ZSCommunity', :path => "zhuishushenqi/NewVersion/ZSCommunity"
#pod 'ZSDiscover', :path => "zhuishushenqi/NewVersion/ZSDiscover"
#pod 'ZSMine', :path => "zhuishushenqi/NewVersion/ZSMine"
#pod 'ZSBaseUIExt', :path => "zhuishushenqi/NewVersion/ZSBaseUIExt"

#pod 'ZSBookShelf'
#pod 'ZSBookStore'
#pod 'ZSCommunity'
#pod 'ZSDiscover'
#pod 'ZSMine'

#pod 'DoraemonKit/Core', '~> 1.1.6', :configurations => ['Debug']
#pod 'DoraemonKit/WithLogger', '~> 1.1.6', :configurations => ['Debug']
#pod 'DoraemonKit/WithGPS', '~> 1.1.6', :configurations => ['Debug']
#pod 'DoraemonKit/WithLoad', '~> 1.1.6', :configurations => ['Debug']
#pod 'AFNetworking'
#pod 'Realm', git: 'git@github.com:realm/realm-cocoa.git', branch: branch, submodules: true
#pod 'RealmSwift', git: 'git@github.com:realm/realm-cocoa.git', branch: branch, submodules: true
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    # 我們也可以懶惰不用 if，讓所有 pod 的版本都設為一樣的
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
    end
    
#    if ['RxSwift', 'RxSwiftExt', 'RxCocoa', 'RxDataSources', 'ProtocolBuffers-Swift'].include? target.name
#    end
  end
end
