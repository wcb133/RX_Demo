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

# git提交规范
# feat：新功能（feature）
# fix：修补bug
# docs：文档（documentation）
# style： 格式（不影响代码运行的变动）
# refactor：重构（即不是新增功能，也不是修改bug的代码变动）
# test：增加测试
# chore：构建过程或辅助工具的变动

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

pod 'RxOptional'
pod 'RxSwiftNotifications' #https://github.com/leandromperez/rxswift-notifications
pod 'RxUIAlert' #https://github.com/RxSwiftCommunity/RxAlert

pod 'Texture'
pod 'Then'
pod 'ReactorKit'
pod 'YogaKit', '~> 1.18'
pod 'Foil', '~> 2.0.0'
pod 'NSObject+Rx' #提供rx_disposeBag

pod 'HandyJSON'

# 代码格式化
pod 'SwiftFormat/CLI', '0.49.1', :configurations => ['Debug']

# 依赖注入框架
#pod "Resolver"

#pod 'Swinject'
pod 'SwinjectAutoregistration',:git=>'git@github.com:wcb133/SwinjectAutoregistration.git', :tag => '2.8.2'

pod 'FLEX', :configurations => ['Debug']  # https://github.com/Flipboard/FLEX

pod 'DeviceKit', '~> 4.0'

# 无用代码检测工具
pod 'Periphery', :configurations => ['Debug']

# swift的扩展（可学习）
pod 'SwifterSwift'

pod 'SwiftMessages'

# 元编程，自动生成模板代码
pod 'Sourcery', :configurations => ['Debug']



pod 'IQKeyboardManagerSwift'

# 日期控件 https://github.com/malcommac/SwiftDate
 pod 'SwiftDate'
 
 pod 'SkeletonView'
 
 pod 'CTMediator'
 
 pod 'IGListKit'
 
 pod 'Hue'
 

 

 

end
