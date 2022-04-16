source 'git@gitee.com:mirrors/CocoaPods-Specs.git'

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
pod 'ReactorKit', '~> 3.1.0'
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

# swift的扩展
pod 'SwifterSwift'

end
