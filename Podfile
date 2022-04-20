source 'git@gitee.com:mirrors/CocoaPods-Specs.git'

# pod 'AFNetworking'                 //不显式指定依赖库版本，表示每次都获取最新版本
# pod 'AFNetworking', '~>0'          //高于0的版本，写这个限制和什么都不写是一个效果，都表示使用最新版本
#
# pod 'AFNetworking', '~> 0.1.2'     //使用大于等于0.1.2但小于0.2的版本
# pod 'AFNetworking', '~>0.1'        //使用大于等于0.1但小于1.0的版本
#
# pod 'AFNetworking', '2.0'          //只使用2.0版本
# pod 'AFNetworking', '= 2.0'        //只使用2.0版本
#
# pod 'AFNetworking', '> 2.0'        //使用高于2.0的版本
# pod 'AFNetworking', '>= 2.0'       //使用大于或等于2.0的版本
# pod 'AFNetworking', '< 2.0'        //使用小于2.0的版本
# pod 'AFNetworking', '<= 2.0'       //使用小于或等于2.0的版本
#
# pod 'AFNetworking', :git => 'http://gitlab.xxxx.com/AFNetworking.git', :branch => 'R20161010'  //指定分支
#
# pod 'AFNetworking',  :path => '../AFNetworking'  //指定本地库

platform :ios, '10.0'
#不显示警告
inhibit_all_warnings!
use_frameworks!

def test_pods
    pod 'RxTest'
    pod 'RxBlocking'
    pod 'Nimble'
    pod 'Quick'
end

target 'RX_DemoTests' do
  test_pods
end


target 'RX_Demo' do
  # Comment the next line if you don't want to use dynamic frameworks
  
pod 'RxSwift', '~> 6'
pod 'RxCocoa', '~> 6'
pod 'SnapKit'
pod 'RxDataSources'
pod 'RxSwiftExt'
pod 'Texture'
pod 'Then'
pod 'ReactorKit'
pod 'YogaKit', '~> 1.18'
pod 'Foil', '~> 2.0.0'
pod 'NSObject+Rx' #提供rx_disposeBag

# 代码格式化
pod 'SwiftFormat/CLI', '0.49.1', :configurations => ['Debug']

# 依赖注入框架
#pod "Resolver"

#pod 'Swinject'
pod 'SwinjectAutoregistration',:git=>'git@github.com:wcb133/SwinjectAutoregistration.git', :tag => '2.8.2'

pod 'FLEX', :configurations => ['Debug']  # https://github.com/Flipboard/FLEX

pod 'DeviceKit', '~> 4.0'

# 无用代码检测工具
pod 'Periphery'

# swift的扩展（可学习）
pod 'SwifterSwift'

pod 'IQKeyboardManagerSwift'

# 日期控件 https://github.com/malcommac/SwiftDate
 pod 'SwiftDate'
 
 # 最新版的是swiftUI了
 pod 'WhatsNewKit'
 
 pod 'SkeletonView'
 
 
 
 

 

 

end
