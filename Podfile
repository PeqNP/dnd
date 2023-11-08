ENV['COCOAPODS_DISABLE_STATS'] = "true"
install! 'cocoapods', :warn_for_unused_master_specs_repo => false

platform :ios, '17.0'

require 'cocoapods-catalyst-support'
inhibit_all_warnings!
use_frameworks!

def simple_view_model
    pod 'SimpleViewModel', :git => 'https://github.com/PeqNP/SimpleViewModel'
end
def swinject
    pod 'Swinject', '2.6.2'
end

def app_pods
    simple_view_model
    swinject
end

target 'dnd iOS' do
    app_pods
end

target 'dnd macOS' do
    app_pods
end

target 'dndTests' do
    app_pods
    pod 'SimpleViewModelTest', :git => 'https://github.com/PeqNP/SimpleViewModel'
end

catalyst_configuration do
    verbose!

    # Example of how to include an iOS specific pod
    #ios 'EmbraceIO'
    #ios 'NewRelicAgent'
    # Example of how to include a macOS specific pod
    #macos 'EmbraceIO'
end

post_install do |installer|
    installer.aggregate_targets.each do |target|
      target.xcconfigs.each do |variant, xcconfig|
        xcconfig_path = target.client_root + target.xcconfig_relative_path(variant)
        IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
      end
    end
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'

            if config.base_configuration_reference.is_a? Xcodeproj::Project::Object::PBXFileReference
              xcconfig_path = config.base_configuration_reference.real_path
              IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
            end
        end
    end
    installer.configure_catalyst
end
