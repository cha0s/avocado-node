{
  'target_defaults': {
    'defines': [
      'AVOCADO_NODE'
    ],
    'cflags!': [ '-fno-exceptions', '-fno-rtti' ],
    'cflags_cc!': [ '-fno-exceptions', '-fno-rtti' ],
    'libraries': [
      '-lboost_filesystem',
      '-lboost_regex',
      '-lboost_system',
      '-lboost_program_options',
    ],
    'include_dirs': [
      '..',
      '../core/deps',
    ],
    "sources": [
      "../SPI/v8/Script/avocado-v8.cpp",
      "../SPI/v8/Script/ObjectWrap.cpp"
    ]
  },
  "targets": [
    {
      "target_name": "Core",
      "sources": [
        "../core/FS.cpp",
        "../SPI/v8/Script/v8CoreService.cpp",
        "../core/Core/CoreService.cpp",
      ]
    },
    {
      "target_name": "Graphics",
      "sources": [
        "../core/Graphics/Canvas.cpp",
        "../SPI/v8/Script/v8Canvas.cpp",
        "../core/Graphics/Font.cpp",
        "../SPI/v8/Script/v8Font.cpp",
        "../core/Graphics/GraphicsService.cpp",
        "../SPI/v8/Script/v8GraphicsService.cpp",
        "../core/Graphics/Image.cpp",
        "../SPI/v8/Script/v8Image.cpp",
        "../core/Graphics/Window.cpp",
        "../SPI/v8/Script/v8Window.cpp",
      ]
    },
    {
      "target_name": "Sound",
      "sources": [
        "../SPI/v8/Script/v8SoundService.cpp",
        "../core/Sound/SoundService.cpp",
        "../SPI/v8/Script/v8Music.cpp",
        "../core/Sound/Music.cpp",
        "../SPI/v8/Script/v8Sample.cpp",
        "../core/Sound/Sample.cpp",
      ]
    },
    {
      "target_name": "Timing",
      "sources": [
        "../SPI/v8/Script/v8TimingService.cpp",
        "../core/Timing/TimingService.cpp",
        "../SPI/v8/Script/v8Counter.cpp",
        "../core/Timing/Counter.cpp",
      ]
    }
  ]
}
