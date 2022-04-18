Pod::Spec.new do |spec|
  spec.name         = "Prelude"
  spec.version      = "0.0.1"
  spec.summary      = "Tool belt for common helper functions in swift."
  spec.description  = <<-DESC
A tool belt of common helper functions and extensions used throughout applications.
                   DESC

  spec.homepage     = "https://github.com/JustinGuedes/prelude"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Justin Guedes" => "justin.guedes@gmail.com" }

  spec.swift_version = "5.5"
  spec.ios.deployment_target = "12.0"
  spec.osx.deployment_target = "10.9"

  spec.source       = { :git => "https://github.com/JustinGuedes/prelude.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/Prelude", "Sources/Prelude/**/*.{swift}", "Sources/Prelude/**/**/*.{swift}"
end
